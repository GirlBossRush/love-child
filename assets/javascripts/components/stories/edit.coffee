React              = require("react")

Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")

title              = require("../../helpers/title")
{api}              = require("../../helpers/path")
Router             = require("react-router")

View               = require("./shared/story-editor")
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-edit"
  mixins: [ReactFireMixin, Router.State]

  render: ->
    if @state.story
      <View story={@state.story} storyRef={@storyRef} />
    else
      <ContentPlaceholder />

  componentDidUpdate: ->
    @setTitle()

  componentWillMount: ->
    @storyRef = new Firebase(api("stories/#{@getParams().id}"))
    @bindAsObject(@storyRef, "story")

  getInitialState: ->
    story: null

  setTitle: ->
    document.title = if @state.story
      text = @state.story.title?.replace("&nbsp;", "") or "untitled"
      title("Editing #{text}")
    else
      title()

