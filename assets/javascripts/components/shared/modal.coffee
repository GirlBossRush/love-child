# React component for Bootstrap modals.
# Accepts an array of React objects for the body and actions.
# Arguments:
# * Type: String
# * Title: String
# * Body: React DOM
# * Actions: React DOM (Most likely an array).

React          = require("react")
R              = React.DOM
_              = require("underscore")

Modal = React.createClass
  displayName: "modal"

  render: ->
    R.div {
      className: "modal fade",
      key: @state.id,
      id: @state.id,
      tabIndex: "-1",
      role: "dialog",
      "aria-labelledby": @props.type,
      "aria-hidden": "true"
    },

      R.div {className: "modal-dialog modal-sm"},
        R.div {className: "modal-inner"},
          R.div {className: "modal-content"},
            R.header {className: "modal-header"},
              R.h5 {className: "modal-title #{@state.type}", id: @props.type}, @state.title

            R.article {className: "modal-body"}, @props.body

            R.footer {className: "modal-footer"},
              R.div {className: "actions"}, @props.actions

  getInitialState: ->
    id: _.uniqueId("modal")
    type: @props.type || "info"
    title: @props.title || "Information"

  # REFACTOR: This is a bit odd since Bootstrap's interface is jQuery heavy.
  componentDidMount: ->
    $(@getDOMNode()).modal("show")

  componentDidUpdate: ->
    $(@getDOMNode()).modal("show")

  componentWillUnmount: ->
    $(@getDOMNode()).modal("hide")


module.exports = Modal
