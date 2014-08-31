React              = require("react")
R                  = React.DOM
Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")
documentHelper     = require("../../lib/document-helper")
apiPath            = require("../../lib/path-helper").api
View               = require("./shared/stories-listing")
ContentPlaceholder = require("../shared/content-placeholder")
_                  = require("underscore")

module.exports = React.createClass
  displayName: "story-index"
  mixins: [ReactFireMixin]

  render: ->
    if @state.stories
      View(storiesRef: @storiesRef, stories: @state.stories, onChange: @handleChange)
    else
      ContentPlaceholder()

  handleChange: ->
    @forceUpdate()

  componentDidUpdate: ->
    @setTitle()

  componentWillMount: ->
    @storiesRef = new Firebase(apiPath("stories"))
    @bindAsObject(@storiesRef.limit(100), "stories")

  getInitialState: ->
    stories: null

  setTitle: ->
    documentHelper.title = "(#{_.size(@state.stories)}) Stories"
