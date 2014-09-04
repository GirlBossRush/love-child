React = require("react")
{aside, section} = React.DOM

module.exports = React.createClass
  displayName: "view-controls"

  render: ->
    aside {className: "view-controls"},
      section {className: "primary-controls"},
        @props.primaryControls.map (component) ->
          component
