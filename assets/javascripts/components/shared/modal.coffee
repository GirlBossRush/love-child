# React component for Bootstrap modals.
# Accepts an array of React objects for the body and actions.
# Arguments:
# * Type: String
# * Title: String
# * Body: React DOM
# * Actions: React DOM (Most likely an array).

React = require("react")
{header, footer, div, article, h5} = React.DOM
{uniqueId} = require("underscore")

Modal = React.createClass
  displayName: "modal"

  render: ->
    div {
      className: "modal fade",
      key: @state.id,
      id: @state.id,
      tabIndex: "-1",
      role: "dialog",
      "aria-labelledby": @props.type,
      "aria-hidden": "true"
    },

      div {className: "modal-dialog modal-sm"},
        div {className: "modal-inner"},
          div {className: "modal-content"},
            header {className: "modal-header"},
              h5 {className: "modal-title #{@state.type}", id: @props.type}, @state.title

            article {className: "modal-body"}, @props.body

            footer {className: "modal-footer"},
              div {className: "actions"}, @props.actions

  getInitialState: ->
    id: uniqueId("modal")
    type: @props.type or "info"
    title: @props.title or "Information"

  # REFACTOR: This is a bit odd since Bootstrap's interface is jQuery heavy.
  componentDidMount: ->
    $(@getDOMNode()).modal("show")

  componentDidUpdate: ->
    $(@getDOMNode()).modal("show")

  componentWillUnmount: ->
    $(@getDOMNode()).modal("hide")


module.exports = Modal
