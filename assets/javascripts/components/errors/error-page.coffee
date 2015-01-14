React = require("react")
title = require("../../helpers/title")
Router = require("react-router")

ErrorPage = React.createClass
  mixins: [Router.State]
  displayName: "errorPage"

  render: ->
    message = @props.message or "'#{@getParams().splat}' is invalid."

    <div className="error-page" data-code=@props.code>
      <h1>{@props.code}</h1>
      <p>{message}</p>
    </div>

  componentDidMount: ->
    document.title = title("#{@props.code} - Error")

module.exports = ErrorPage
