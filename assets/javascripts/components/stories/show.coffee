React              = require("react")
R                  = React.DOM
AsyncState         = require("react-router/AsyncState")
Story              = require("../../models/story")
documentHelper     = require("../../lib/document-helper")
View               = require("./shared/story")
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-show"
  mixins: [AsyncState]

  statics:
    getInitialAsyncState: (params, query, setState) ->
      new Story(id: params.id).fetch
        success: (model) ->
          setState(story: model)

  render: ->
    if @state.story
      View(story: @state.story)
    else
      ContentPlaceholder()

  componentDidUpdate: ->
    @setTitle()

  getInitialState: ->
    story: null

  setTitle: ->
    title = @state.story.title
    documentHelper.title = title?.replace("&nbsp;", "") or "untitled"
