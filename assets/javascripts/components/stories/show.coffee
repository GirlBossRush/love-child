React          = require("react")
R              = React.DOM
HumanTime      = require("../shared/human-time")
DocumentHelper = require("../../lib/document-helper")

module.exports = React.createClass
  displayName: "story"

  render: ->
    R.section {className: "story"},
      @fullscreenRender()
      R.header {className: "headline"},
        R.div {className: "title"}, @props.story.title
        R.div {className: "description"}, @props.story.description
        R.div {className: "author"}, @props.story.author
        HumanTime {datetime: @props.story.updated_at}
        R.hr {className: "section-seperator"}

      R.article
        className: "body"
        dangerouslySetInnerHTML:
          __html: @props.story.body

      R.footer {className: "summary"}

  fullscreenRender: ->
    icon  = "fullscreen"
    label = "Fullscreen"

    console.log("status is", DocumentHelper.fullscreen)

    if DocumentHelper.fullscreen
      icon  = "remove"
      label = "Close"

    R.span {className: "toggle-fullscreen no-print", onClick: @toggleFullscreen},
      R.span {className: "toggle-label"}, label
      R.span {className: "glyphicon glyphicon-#{icon} toggle-icon"}

  toggleFullscreen: ->
    DocumentHelper.fullscreen = !DocumentHelper.fullscreen

  componentDidMount: ->
    document.addEventListener "fullscreenchange", =>
      @forceUpdate()

