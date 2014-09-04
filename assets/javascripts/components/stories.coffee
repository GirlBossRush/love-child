React = require("react")
{div} = React.DOM

Stories = React.createClass
  render: ->
    div {className: "stories-root"}, @props.activeRouteHandler()

module.exports = Stories
