React = require("react")
{div, h1, p} = React.DOM

title = require("../../helpers/title")

ErrorPage = React.createClass
  displayName: "errorPage"

  render: ->
    message = @props.message or "'#{@props.params.splat}' is invalid."
    div {className: "error-page", "data-code": @props.code},
      h1 null, @props.code
      p null, message

  componentDidMount: ->
    document.title = title("#{@props.code} - Error")

module.exports = ErrorPage
