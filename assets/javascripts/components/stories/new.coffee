React              = require("react")

Router             = require("react-router")

Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")

{api}              = require("../../helpers/path")
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-new"

  mixins: [ReactFireMixin, Router.Navigation]

  render: ->
    if @state.story
      @transitionTo("story-edit", {id: @storyRef.name()})
    <ContentPlaceholder />

  componentWillMount: ->
    @storiesRef = new Firebase(api("stories"))
    @storyRef = @storiesRef.push
      title: ""
      body: ""
      description: ""
      createdAt: Firebase.ServerValue.TIMESTAMP
      updatedAt: Firebase.ServerValue.TIMESTAMP

    @bindAsObject(@storyRef, "story")

  getInitialState: ->
    story: null

