# Placeholder component. Used to fill in loading wait time.

React  = require("react")
R      = React.DOM

ContentPlaceholder = React.createClass
  displayName: "content-placeholder"

  render: ->
    R.div {className: "content-placeholder"}, "Loading"

module.exports = ContentPlaceholder
