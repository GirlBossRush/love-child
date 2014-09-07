React = require("react")
{section, div, article, header, footer, hr} = React.DOM

{extend, debounce}   = require("underscore")
MediumEditor         = require("medium-editor")
markdown             = require("../../../helpers/markdown")
html2markdown        = require("html2markdown")
Internuncio          = require("internuncio")

userPreferences      = require("../../../helpers/user-preferences")
humanTime            = require("../../shared/human-time")
estimatedReadingTime = require("../../shared/estimated-reading-time")
validations          = require("./validations")

viewControls         = require("./view-controls")
readingPreferences   = require("./view-controls/reading-preferences")

savedState           = require("./view-controls/saved-state")

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

    section {className: "story edit"},
      viewControls
        primaryControls: [
          savedState(isSaving: @state.isSaving, isSaved: @state.isSaved)

          estimatedReadingTime(textComponent: @refs.body)
        ]

        secondaryControls: [
          readingPreferences(storyComponent: this)
        ]

      header {className: "headline"},
        div
          ref: "title"
          className: "title"
          "data-placeholder": "Title"
          "data-parser": "plaintext"
          contentEditable: true
          onInput: @handleContentChange

        div
          ref: "description"
          className: "description",
          "data-placeholder": "Description"
          "data-parser": "markdown"
          contentEditable: true
          onInput: @handleContentChange,

        div {className: "author"}, @state.story.author
        humanTime {datetime: @state.story.updatedAt}
        hr {className: "section-seperator"}

      article
        ref: "body"
        className: "body"
        "data-width": paragraphWidth
        "data-font-size": fontSize
        "data-placeholder": "Your story begins..."
        "data-parser": "markdown"
        contentEditable: true
        onInput: @handleContentChange

      footer {className: "summary"}

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
