React = require("react")
{div, aside, main} = React.DOM

SiteMenu        = require("./shared/site-menu")
SiteNavigation  = require("./shared/site-navigation")
navigationItems = require("./shared/side-menu/navigation-items")

navigationClass = "site-navigation-active"

Application = React.createClass
  render: ->
    div {className: "application-root"},
      div {id: "above-content"}

      SiteNavigation({navigationItems, onNavigation: @disableNavigationClass})
      aside {className: "site-navigation-overlay", onClick: @disableNavigationClass}

      main {id: "main-content"},
        SiteMenu(onNavigation: @enableNavigationClass)
        @props.activeRouteHandler()

  enableNavigationClass: ->
    document.body.classList.add(navigationClass)

  disableNavigationClass: ->
    document.body.classList.remove(navigationClass)

module.exports = Application
