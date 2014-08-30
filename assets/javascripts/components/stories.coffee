React           = require("react")
R               = React.DOM

Stories = React.createClass
  render: ->
    R.div {className: "stories-root"}, @props.activeRouteHandler()

module.exports = Stories
