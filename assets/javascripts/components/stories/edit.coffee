React              = require("react")
R                  = React.DOM
Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")
documentHelper     = require("../../lib/document-helper")
apiPath            = require("../../../../util/path-helper").api

View               = require("./shared/story-editor")
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-edit"
  mixins: [ReactFireMixin]

  render: ->
    if @state.story
      View(story: @state.story, storyRef: @storyRef)
    else
      ContentPlaceholder()

  componentDidUpdate: ->
    @setTitle()

  componentWillMount: ->
    @storyRef = new Firebase(apiPath("stories/#{@props.params.id}"))
    @bindAsObject(@storyRef, "story")

  getInitialState: ->
    story: null

  setTitle: ->
    title = @state.story.title?.replace("&nbsp;", "") or "untitled"
    documentHelper.title = ["Editing #{title}"]
