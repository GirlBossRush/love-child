React                = require("react")
R                    = React.DOM
_                    = require("underscore")
MediumEditor         = require("medium-editor")
htmlToText           = require("html-to-text")
userPreferences      = require("../../users/preferences")
humanTime            = require("../../shared/human-time")
estimatedReadingTime = require("../../shared/estimated-reading-time")
validations          = require("./validations")
viewControls         = require("./view-controls")
savedState           = require("./view-controls/saved-state")
fullscreenToggle     = require("./view-controls/fullscreen-toggle")



UPDATE_THROTTLE = 1500
contentEditableFields = ["title", "description", "body"]

StoryEditor = React.createClass
  displayName: "story-editor"

  render: ->
    R.section {className: "story edit"},
      viewControls
        primaryControls: [
          savedState.bind this,
            isSaving: @state.isSaving
            isSaved: @state.isSaved

          estimatedReadingTime.bind(this, textComponent: @refs.body, text: htmlToText.fromString(@state.story.body) )

          fullscreenToggle
        ]

      R.header {className: "headline"},
        R.div
          ref: "title"
          className: "title"
          onInput: @handleContentChange
          contentEditable: true
          "data-placeholder": "Title"

        R.div
          ref: "description"
          className: "description",
          "data-placeholder": "Description"
          onInput: @handleContentChange,
          contentEditable: true

        R.div {className: "author"}, @state.story.author
        humanTime {datetime: @state.story.updated_at}
        R.hr {className: "section-seperator"}

      R.article
        ref: "body"
        className: "body"
        "data-width": @state.paragraphWidth
        "data-font-size": @state.paragraphFontSize
        "data-placeholder": "Your story begins..."
        contentEditable: true
        onInput: @handleContentChange

      R.footer {className: "summary"}

  saveStory: _.debounce ->
    model = @state.model
    model.set(@state.story)

    @state.isSaving = true
    @forceUpdate()

    model.save @state.story,
      success: =>
        @state.isSaving = false
        @state.isSaved  = true

        @forceUpdate()

      error: =>
        @state.isSaving = false
        @state.isSaved  = false

        @forceUpdate()

  , UPDATE_THROTTLE

  handleContentChange: (e) ->
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

    bodyCaretPosition: 0

    model: @props.story
    story: @props.story

module.exports = StoryEditor
