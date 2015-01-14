React              = require("react")

Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")

title              = require("../../helpers/title")
{api}              = require("../../helpers/path")
Router             = require("react-router")

View               = require("./shared/story")
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-show"

  mixins: [ReactFireMixin, Router.State]

  render: ->
    if @state.story
      <View story={@state.story} />
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
      title(@state.story.title?.replace("&nbsp;", "") or "untitled")
    else
      title()
