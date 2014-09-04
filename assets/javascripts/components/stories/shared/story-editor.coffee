React = require("react")
{section, div, article, header, footer, hr} = React.DOM

{extend, debounce}   = require("underscore")
MediumEditor         = require("medium-editor")
htmlToText           = require("html-to-text")
Internuncio          = require("internuncio")

userPreferences      = require("../../users/preferences")
humanTime            = require("../../shared/human-time")
estimatedReadingTime = require("../../shared/estimated-reading-time")
validations          = require("./validations")

viewControls         = require("./view-controls")
savedState           = require("./view-controls/saved-state")
fullscreenToggle     = require("./view-controls/fullscreen-toggle")

logger = new Internuncio("Story Listing")
UPDATE_THROTTLE = 1500
contentEditableFields = ["title", "description", "body"]

StoryEditor = React.createClass
  displayName: "story-editor"

  render: ->
    section {className: "story edit"},
      viewControls
        primaryControls: [
          savedState.bind this,
            isSaving: @state.isSaving
            isSaved: @state.isSaved

          estimatedReadingTime.bind(this, textComponent: @refs.body, text: htmlToText.fromString(@state.story.body) )

          fullscreenToggle
        ]

      header {className: "headline"},
        div
          ref: "title"
          className: "title"
          onInput: @handleContentChange
          contentEditable: true
          "data-placeholder": "Title"

        div
          ref: "description"
          className: "description",
          "data-placeholder": "Description"
          onInput: @handleContentChange,
          contentEditable: true

        div {className: "author"}, @state.story.author
        humanTime {datetime: @state.story.updatedAt}
        hr {className: "section-seperator"}

      article
        ref: "body"
        className: "body"
        "data-width": @state.paragraphWidth
        "data-font-size": @state.paragraphFontSize
        "data-placeholder": "Your story begins..."
        contentEditable: true
        onInput: @handleContentChange

      footer {className: "summary"}

  saveStory: debounce ->
    @state.isSaving = true
    @forceUpdate()

    @state.storyRef.transaction =>
      extend {}, @state.story, {updatedAt: Firebase.ServerValue.TIMESTAMP}
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
    new MediumEditor(body)

    body.focus()

  populateContentEditableFields: ->
    # Contenteditable fields must be assigned outside of React's update cycle.
    # Otherwise the cursor position will be lost on each update.
    for field in contentEditableFields
      @refs[field].getDOMNode().innerHTML = @state.story[field]

    @forceUpdate()

  updateContentEditableFields: ->
    # Fetch data from DOM, update model attributes.
    for field in contentEditableFields
      @state.story[field] = @refs[field].getDOMNode().innerHTML

  getInitialState: ->
    paragraphFontSize: userPreferences.stories.fontSize
    paragraphWidth: userPreferences.stories.paragraphWidth

    isSaving: false
    isSaved: true

    # Remote model reference.
    storyRef: @props.storyRef
    # Model used for editing.
    story: @props.story

module.exports = StoryEditor
