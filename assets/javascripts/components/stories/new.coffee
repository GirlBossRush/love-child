React              = require("react")
R                  = React.DOM
Router             = require("react-router")
AsyncState         = require("react-router/AsyncState")
Story              = require("../../models/story")
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-new"
  mixins: [AsyncState]

  statics:
    getInitialAsyncState: (params, query, setState) ->
      new Story().save {},
        success: (model) ->
          setState(story: model)

  render: ->
    if @state.story
      Router.transitionTo("story-edit", {id: @state.story.id})
    ContentPlaceholder()

  getInitialState: ->
    story: null

