React           = require("react")
R               = React.DOM
documentHelper  = require("../../lib/document-helper")

ErrorPage = React.createClass
  displayName: "errorPage"

  render: ->
    R.div {className: "error-page", "data-code": @props.code},
      R.h1 null, @props.code
      R.p null, "'#{@props.path}' is invalid."

  componentDidMount: ->
    documentHelper.title = "#{@props.code} - Error"

module.exports = ErrorPage
