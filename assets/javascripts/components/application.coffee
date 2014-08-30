React           = require("react")
R               = React.DOM
SideMenu        = require("./shared/side-menu")
navigationItems = require("./shared/side-menu/navigation-items")

Application = React.createClass
  render: ->
    R.div {className: "application-root"},
      R.div {id: "above-content"}

      R.aside {id: "aside-content"},
        SideMenu({navigationItems})

      R.main {className: "container", id: "main-content"}, @props.activeRouteHandler()

module.exports = Application
