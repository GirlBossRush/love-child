React = require("react")

SiteMenu        = require("./shared/site-menu")
SiteNavigation  = require("./shared/site-navigation")
navigationItems = require("./shared/side-menu/navigation-items")
{RouteHandler}  = require("react-router")

navigationClass = "site-navigation-active"

Application = React.createClass
  render: ->
    <div className="application-root">
      <div id="above-content" />

      <SiteNavigation navigationItems={navigationItems} onNavigation={@disableNavigationClass} />
      <aside className="site-navigation-overlay" onClick={@disableNavigationClass} />

      <main id="main-content">
        <SiteMenu onNavigation={@enableNavigationClass} />
        <RouteHandler />
      </main>
    </div>

  enableNavigationClass: ->
    document.body.classList.add(navigationClass)

  disableNavigationClass: ->
    document.body.classList.remove(navigationClass)

module.exports = Application
