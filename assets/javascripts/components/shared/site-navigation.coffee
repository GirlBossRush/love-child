# Site navigation component.
# Arguments:
# * navigationItems: Array of objects {label, icon, path}.

React = require("react")
{Link} = require("react-router")

module.exports = React.createClass
  displayName: "site-navigation"

  navigationItem: (item, key) ->
    <Link to=item.path params={{}} className="list-group-item" key={key} onClick={@props.onNavigation}>
      <span className="accent glyphicon glyphicon-#{item.icon}" />
      <span className="item-label">
        {item.label}
      </span>
    </Link>

  render: ->
    <nav className="site-navigation no-print">
      <div className="list-group">{
        for item, i in @props.navigationItems
          @navigationItem(item, i)
      }</div>
    </nav>
