React              = require("react")

Firebase           = require("firebase")
ReactFireMixin     = require("reactfire")

title              = require("../../helpers/title")
{api}              = require("../../helpers/path")
{size}             = require("underscore")

View               = require("./shared/stories-listing")
ContentPlaceholder = require("../shared/content-placeholder")

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
    @storiesRef = new Firebase(api("stories"))
    @bindAsObject(@storiesRef.limit(100), "stories")

  getInitialState: ->
    stories: null

  setTitle: ->
    storyCount = if @state.stories
      size(@state.stories)
    else
      0

    document.title = title("(#{storyCount}) Stories")
