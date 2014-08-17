React          = require("react")
R              = React.DOM
fullscreenToggle = require("../../shared/fullscreen-toggle")

module.exports = React.createClass
  displayName: "view-controls"

  render: ->
    fullscreenToggle()
