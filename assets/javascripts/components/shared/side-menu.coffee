# Side menu component.
# Arguments:
# * navigationItems: Array of objects {label, icon, path}.

React          = require("react")
{div, span}    = React.DOM
{Link}         = require("react-router")
documentHelper = require("../../lib/document-helper")

module.exports = React.createClass
  displayName: "sideMenu"

  navigationItem: (item, key) ->
    Link {to: item.path, params: {}, className: "list-group-item", key},
      span {className: "item-label"}, item.label
      span {className: "accent glyphicon glyphicon-#{item.icon}"}, ""

  render: ->
    div {className: "menu-content no-print"},
      div {className: "list-group"},
        for item, i in @props.navigationItems
          @navigationItem(item, i)
