# React component for Bootstrap modals.
# Accepts an array of React objects for the body and actions.
# Arguments:
# * Type: String
# * Title: String
# * Body: React DOM
# * Actions: React DOM (Most likely an array).

React = require("react")
{uniqueId} = require("lodash")

Modal = React.createClass
  displayName: "modal"

  render: ->
    <div
      className="modal fade"
      key={@state.id}
      id={@state.id}
      tabIndex="-1"
      role="dialog"
      "aria-labelledby"={@props.type}
      "aria-hidden"="true"
    >
      <div className="modal-dialog modal-sm">
        <div className="modal-inner">
          <div className="modal-content">
            <header className="modal-header">
              <h5 className="modal-title #{@state.type}" id={@props.type}>
                {@state.title}
              </h5>
            </header>

            <article className="modal-body">{@props.children}</article>

            <footer className="modal-footer">
              <div className="actions">{@props.actions}</div>
            </footer>
          </div>
        </div>
      </div>
    </div>

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
