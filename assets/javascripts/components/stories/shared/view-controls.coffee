React = require("react")
{aside, section} = React.DOM

module.exports = React.createClass
  displayName: "view-controls"

  render: ->
    aside {className: "view-controls no-mobile no-print"},
      section {className: "primary-controls"},
        @props.primaryControls.map (component) ->
          component

      section {className: "secondary-controls"},
        @props.secondaryControls.map (component) ->
          component

  getDefaultProps: ->
    primaryControls: []
    secondaryControls: []
