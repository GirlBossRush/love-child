#= require modernizr/modernizr
#= require bootstrap

DocumentHelper    = require("./lib/document-helper")

ApplicationRouter = require("./routers/application")
StoriesRouter     = require("./routers/stories")
History           = require("ampersand-router/ampersand-history")

SideMenu          = require("./components/shared/side-menu")
navigationItems   = require("./components/shared/side-menu/navigation-items")

# Necessary for some plugins.
window.$ = require("jquery")

$ ->
  new ApplicationRouter()
  new StoriesRouter()

  History.start(pushState: true)

  DocumentHelper.render
    component: SideMenu({navigationItems})
    anchor: "asideContent"
