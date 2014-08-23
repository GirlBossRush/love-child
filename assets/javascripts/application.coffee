#= require modernizr/modernizr
#= require bootstrap

DocumentHelper    = require("./lib/document-helper")

ApplicationRouter = require("./routers/application")
StoriesRouter     = require("./routers/stories")
UsersRouter       = require("./routers/users")
History           = require("ampersand-router/ampersand-history")

SideMenu          = require("./components/shared/side-menu")
navigationItems   = require("./components/shared/side-menu/navigation-items")

# Necessary for some plugins.
window.$ = require("jquery")

$ ->
  document.documentElement.classList.remove("no-js")
  new ApplicationRouter()
  new StoriesRouter()
  new UsersRouter()

  History.start(pushState: true)

  DocumentHelper.render
    component: SideMenu({navigationItems})
    anchor: "asideContent"
