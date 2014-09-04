React              = require("react")

Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")

title              = require("../../helpers/title")
{api}              = require("../../helpers/path")

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
    @storyRef = new Firebase(api("stories/#{@props.params.id}"))
    @bindAsObject(@storyRef, "story")

  getInitialState: ->
    story: null

  setTitle: ->
    text = @state.story.title?.replace("&nbsp;", "") or "untitled"
    document.title = title("Editing #{text}")
