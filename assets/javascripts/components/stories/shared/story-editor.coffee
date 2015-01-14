React = require("react")

{extend, debounce}   = require("lodash")
MediumEditor         = require("medium-editor")
markdown             = require("../../../helpers/markdown")
html2markdown        = require("html2markdown")
Internuncio          = require("internuncio")

userPreferences      = require("../../../helpers/user-preferences")
HumanTime            = require("../../shared/human-time")
EstimatedReadingTime = require("../../shared/estimated-reading-time")
validations          = require("./validations")

ViewControls         = require("./view-controls")
ReadingPreferences   = require("./view-controls/reading-preferences")

SavedState           = require("./view-controls/saved-state")

logger = new Internuncio("Story Listing")

MEDIUM_OPTIONS =
  cleanPastedHTML: true
  disableDoubleReturn: true
  firstHeader: "h1"
  secondHeader: "h2"
  buttons: ["bold", "italic", "underline", "quote", "header1", "header2"]
  buttonLabels:
    bold: "<span class='glyphicon glyphicon-bold'></span>"
    italic: "<span class='glyphicon glyphicon-italic'></span>"
    bold: "<span class='glyphicon glyphicon-bold'></span>"

UPDATE_THROTTLE = 1500
contentEditableFields = ["title", "description", "body"]

StoryEditor = React.createClass
  displayName: "story-editor"

  render: ->
    {fontSize, paragraphWidth} = userPreferences.stories

    <section className="story edit">
      <ViewControls
        primaryControls={[
          <SavedState isSaving={@state.isSaving} isSaved={@state.isSaved} />

          <EstimatedReadingTime textComponent={@refs.body} />
        ]}

        secondaryControls={[
          <ReadingPreferences storyComponent=this />
        ]}
      />

      <header className="headline">
        <div
          ref="title"
          className="title"
          data-placeholder="Title"
          data-parser="plaintext"
          contentEditable
          onInput={@handleContentChange}
        />

        <div
          ref="description"
          className="description"
          data-placeholder="Description"
          data-parser="markdown"
          contentEditable
          onInput={@handleContentChange}
        />

        <div className="author">
          {@state.story.author}
        </div>
        <HumanTime datetime={@state.story.updatedAt} />
        <hr className="section-seperator" />
      </header>

      <article
        ref="body"
        className="body"
        data-width={paragraphWidth}
        data-font-size={fontSize}
        data-parser="markdown"
        contentEditable
        onInput={@handleContentChange}
      />

      <footer className="summary" />
    </section>

  saveStory: debounce ->
    @state.isSaving = true
    @forceUpdate()

    {title, description, body} = @state.story
    updatedAt                  = Firebase.ServerValue.TIMESTAMP

    @state.storyRef.transaction =>
      return {title, description, body, updatedAt}

    , (error, committed, snapshot) =>
      if error
        logger.error(error)
        @state.isSaving = false
        @state.isSaved  = false

      else
        @state.isSaving = false
        @state.isSaved  = true
        @state.story = snapshot.val()

      @forceUpdate()

  , UPDATE_THROTTLE

  handleContentChange: (e) ->
    # Prevent attempting to save while a transaction is processing.
    if !@state.isSaving
      @state.isSaved = false

      @forceUpdate()

      @updateContentEditableFields()
      @saveStory()

  componentDidMount: ->
    @populateContentEditableFields()

    title = @refs.title.getDOMNode()
    validations.title.init(title)

    body = @refs.body.getDOMNode()

    # Setup editor controls.
    new MediumEditor body, MEDIUM_OPTIONS

    body.focus()

  populateContentEditableFields: ->
    # Contenteditable fields must be assigned outside of React's update cycle.
    # Otherwise the cursor position will be lost on each update.
    for field in contentEditableFields
      fieldDOMNode = @refs[field].getDOMNode()

      fieldDOMNode.innerHTML = if fieldDOMNode.dataset["parser"] is "markdown"
        markdown(@state.story[field])
      else
        @state.story[field]

      # Fix issue where blank stories don't have first paragraph.
      if field is "body" and fieldDOMNode.innerHTML is ""
        fieldDOMNode.innerHTML = "<p class='paragraph-placeholder'>&nbsp;</p>"

    @forceUpdate()

  updateContentEditableFields: ->
    # Fetch data from DOM, update model attributes.
    for field in contentEditableFields
      fieldDOMNode = @refs[field].getDOMNode()

      @state.story[field] = if fieldDOMNode.dataset["parser"] is "markdown"
        html2markdown(fieldDOMNode.innerHTML)
      else
        fieldDOMNode.textContent

  getInitialState: ->
    isSaving: false
    isSaved: true

    # Remote model reference.
    storyRef: @props.storyRef
    # Model used for editing.
    story: @props.story

module.exports = StoryEditor
