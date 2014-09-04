# Placeholder component. Used to fill in loading wait time.

React = require("react")
{div} = React.DOM

ContentPlaceholder = React.createClass
  displayName: "content-placeholder"

  render: ->
    div {className: "content-placeholder"}, "Loading"

module.exports = ContentPlaceholder
