# Necessary for some plugins.
window.$ = window.jQuery = require("jquery")
require("./lib/bootstrap-adapter")

React         = require("react")
Router        = require("react-router")
{Routes, Route, NotFoundRoute, DefaultRoute} = require("react-router")

Application   = require("./components/application")
Stories       = require("./components/stories")
ErrorPage     = require("./components/errors/error-page")

stories =
  index: require("./components/stories/index")
  show:  require("./components/stories/show")
  edit:  require("./components/stories/edit")
  new:   require("./components/stories/new")

routes = Routes {location: "history"},
  Route {name: "root", path: "/", handler: Application},
    DefaultRoute {handler: ErrorPage, code: 204, message: "Alternative Fiction"}

    Route {name: "stories", handler: Stories},
      DefaultRoute {handler: stories.index}
      Route {name: "stories-new", path: "new", handler: stories.new}
      Route {name: "story", path: ":id", handler: stories.show}
      Route {name: "story-edit", path: ":id/edit", handler: stories.edit}

  NotFoundRoute {name: "not-found", handler: ErrorPage, code: 404}
$ ->
  React.renderComponent(routes, document.body)
