# Side menu component.
# Arguments:
# * navigationItems: Array of objects {label, icon, path}.

React          = require("react")
R              = React.DOM
DocumentHelper = require("../../lib/document-helper")

module.exports = React.createClass
  displayName: "sideMenu"

  navigate: (path) ->
    DocumentHelper.navigate(path, true)

  navigationItem: (item) ->
    R.li {className: "list-group-item", key: item.path, onClick: @navigate.bind(this, item.path)},
      item.label
      R.span {className: "accent glyphicon glyphicon-#{item.icon}"}, ""

  render: ->
    R.div {className: "menu-content no-print"},
      R.ul {className: "list-group"},
        @props.navigationItems.map(@navigationItem)
