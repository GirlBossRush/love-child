React              = require("react")
R                  = React.DOM
AsyncState         = require("react-router/AsyncState")
Stories            = require("../../collections/stories")
documentHelper     = require("../../lib/document-helper")
View               = require("./shared/stories-listing")
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-index"
  mixins: [AsyncState]

  statics:
    getInitialAsyncState: (params, query, setState) ->
      new Stories().fetch
        success: (collection) ->
          setState(stories: collection)

  render: ->
    if @state.stories
      View(stories: @state.stories, onChange: @handleChange)
    else
      ContentPlaceholder()

  handleChange: ->
    @forceUpdate()

  componentDidUpdate: ->
    @setTitle()

  getInitialState: ->
    stories: null

  setTitle: ->
    documentHelper.title = "(#{@state.stories.length}) Stories"
