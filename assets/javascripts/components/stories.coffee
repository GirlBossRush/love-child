React = require("react")
{RouteHandler} = require("react-router")

Stories = React.createClass
  render: ->
    <div className="stories-root">
      <RouteHandler />
    </div>

module.exports = Stories
