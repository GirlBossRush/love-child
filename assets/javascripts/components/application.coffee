React = require("react")
{div, aside, main} = React.DOM

SideMenu        = require("./shared/side-menu")
navigationItems = require("./shared/side-menu/navigation-items")

Application = React.createClass
  render: ->
    div {className: "application-root"},
      div {id: "above-content"}

      aside {id: "aside-content"},
        SideMenu({navigationItems})

      main {className: "container", id: "main-content"}, @props.activeRouteHandler()

module.exports = Application
