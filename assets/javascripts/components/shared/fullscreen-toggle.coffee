# Fullscreen toggle button.

React          = require("react")
R              = React.DOM
DocumentHelper = require("../../lib/document-helper")

module.exports = React.createClass
  displayName: "fullscreen-toggle"

  render: ->
    icon  = "fullscreen"
    label = "Fullscreen"

    if DocumentHelper.fullscreen
      icon  = "remove"
      label = "Close"

    R.span {className: "toggle-fullscreen no-print", onClick: @toggleFullscreen},
      R.span {className: "toggle-label"}, label
      R.span {className: "glyphicon glyphicon-#{icon} toggle-icon"}

  toggleFullscreen: ->
    DocumentHelper.fullscreen = !DocumentHelper.fullscreen

  fullscreenChangeListener: ->
    @forceUpdate()

  componentDidMount: ->
    # Avoid tracking fullscreen state inside component.
    # The user may decline or exit fullscreen and be unsynchronized with our state.
    document.addEventListener "fullscreenchange", @fullscreenChangeListener

  componentWillUnmount: ->
    document.removeEventListener "fullscreenchange", @fullscreenChangeListener
