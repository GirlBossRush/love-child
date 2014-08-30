# Side menu component.
# Arguments:
# * navigationItems: Array of objects {label, icon, path}.

React          = require("react")
R              = React.DOM
Link           = require("react-router/link")
documentHelper = require("../../lib/document-helper")

module.exports = React.createClass
  displayName: "sideMenu"

  navigationItem: (item, key) ->
    Link {to: item.path, params: {}, className: "list-group-item", key},
      R.span {className: "item-label"}, item.label
      R.span {className: "accent glyphicon glyphicon-#{item.icon}"}, ""

  render: ->
    R.div {className: "menu-content no-print"},
      R.div {className: "list-group"},
        for item, i in @props.navigationItems
          @navigationItem(item, i)
