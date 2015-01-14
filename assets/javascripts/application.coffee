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

routes = (<Route name="root" path="/" handler={Application}>
<DefaultRoute handler={ErrorPage.bind(this, code: 204, message: "Alternative Fiction")} />

  <Route name="stories" handler={Stories}>
    <DefaultRoute handler={stories.index} />
    <Route name="stories-new" path="new" handler={stories.new} />
    <Route name="story" path=":id" handler={stories.show} />
    <Route name="story-edit" path=":id/edit" handler={stories.edit} />
  </Route>

  <NotFoundRoute name="not-found" handler={ErrorPage.bind(this, code: 404)} />
</Route>)

$ ->
  Router.run routes, Router.HistoryLocation, (Handler) ->
    React.render(<Handler />, document.body)
