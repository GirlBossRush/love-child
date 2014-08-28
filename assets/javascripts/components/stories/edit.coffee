React          = require("react")
R              = React.DOM
documentHelper = require("../../lib/document-helper")
humanTime      = require("../shared/human-time")
validations    = require("./shared/validations")
_              = require("underscore")
MediumEditor   = require("medium-editor")

UPDATE_THROTTLE = 1500
contentEditableFields = ["title", "description", "body"]

StoryEditor = React.createClass
  displayName: "storyEdit"

  render: ->
    R.section {className: "story edit"},
      @saveStateRender()

      R.header {className: "headline"},
        R.div
          className: "title"
          onInput: @handleContentUpdate
          contentEditable: true
          ref: "title"

        R.div
          className: "description",
          onInput: @handleContentUpdate,
          contentEditable: true
          ref: "description"

        R.div {className: "author"}, @state.story.author
        humanTime {datetime: @state.story.updated_at}
        R.hr {className: "section-seperator"}

      R.article
        className: "body"
        ref: "body"
        contentEditable: true
        onInput: @handleContentUpdate

      R.footer {className: "summary"}

  saveStateRender: ->
    attributes = if !@state.isSaving and !@state.isSaved
      text: "Unsaved"
      className: "unsaved"
    else if @state.isSaving
      text: "Saving"
      className: "saving"
    else if @state.isSaved
      text: "Saved"
      className: "saved"
    else
      text: "?"
      className: "unknown"

    R.aside {className: "save-state #{attributes.className}"}, attributes.text

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

  handleContentUpdate: (e) ->
    if !@state.isSaving
      @state.isSaved = false
      @forceUpdate()

      @updateContentEditableFields()

      @saveStory()

  componentDidUpdate: ->
    title = @state.story.title.replace("&nbsp;", "")
    documentHelper.title = ["Edit", title, "Stories"]

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

  updateContentEditableFields: ->
    # Fetch data from DOM, update model attributes.
    for field in contentEditableFields
      @state.story[field] = @refs[field].getDOMNode().innerHTML

  getInitialState: ->
    isSaving: false
    isSaved: true

    bodyCaretPosition: 0

    model: @props.model
    story: @props.model

module.exports = StoryEditor
