# Side menu component.
# Arguments:
# * navigationItems: Array of objects {label, icon, path}.

React          = require("react")
R              = React.DOM
documentHelper = require("../../lib/document-helper")

module.exports = React.createClass
  displayName: "sideMenu"

  navigate: (path) ->
    documentHelper.navigate(path, true)

  navigationItem: (item) ->
    R.li {className: "list-group-item", key: item.path, onClick: @navigate.bind(this, item.path)},
      R.span {className: "item-label"}, item.label
      R.span {className: "accent glyphicon glyphicon-#{item.icon}"}, ""

  render: ->
    R.div {className: "menu-content no-print"},
      R.ul {className: "list-group"},
        @props.navigationItems.map(@navigationItem)
