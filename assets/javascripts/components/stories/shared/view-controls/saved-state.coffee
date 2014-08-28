# Story saved state indicator.

React          = require("react")
R              = React.DOM
documentHelper = require("../../../../lib/document-helper")

module.exports = React.createClass
  displayName: "saved-state"

  render: ->
    attributes = if !@props.isSaving and !@props.isSaved
      text: "Unsaved"
      className: "unsaved"
    else if @props.isSaving
      text: "Saving"
      className: "saving"
    else if @props.isSaved
      text: "Saved"
      className: "saved"
    else
      text: "?"
      className: "unknown"

    R.span {className: "save-state #{attributes.className}"}, attributes.text

