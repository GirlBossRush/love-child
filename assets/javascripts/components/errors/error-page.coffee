React           = require("react")
R               = React.DOM
documentHelper  = require("../../lib/document-helper")

ErrorPage = React.createClass
  displayName: "errorPage"

  render: ->
    message = @props.message or "'#{@props.params.splat}' is invalid."
    R.div {className: "error-page", "data-code": @props.code},
      R.h1 null, @props.code
      R.p null, message

  componentDidMount: ->
    documentHelper.title = "#{@props.code} - Error"

module.exports = ErrorPage
