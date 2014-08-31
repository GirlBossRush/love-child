React              = require("react")
R                  = React.DOM
Router             = require("react-router")
Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")
pathHelper         = require("../../../../util/path-helper")
apiPath            = require("../../../../util/path-helper").api
ContentPlaceholder = require("../shared/content-placeholder")

module.exports = React.createClass
  displayName: "story-new"

  mixins: [ReactFireMixin]

  render: ->
    if @state.story
      Router.transitionTo("story-edit", {id: @storyRef.name()})
    ContentPlaceholder()

  componentWillMount: ->
    @storiesRef = new Firebase(apiPath("stories"))
    @storyRef = @storiesRef.push
      title: ""
      body: ""
      description: ""
      createdAt: Firebase.ServerValue.TIMESTAMP
      updatedAt: Firebase.ServerValue.TIMESTAMP

    @bindAsObject(@storyRef, "story")

  getInitialState: ->
    story: null

