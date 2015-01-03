React = require("react")
{aside, section, span} = React.DOM

module.exports = React.createClass
  displayName: "view-controls"

  render: ->
    aside {className: "view-controls no-mobile no-print"},
      section {className: "primary-controls"},
        for component, i in @props.primaryControls
          span {key: i, className: "control"}, component

      section {className: "secondary-controls"},
        for component, i in @props.secondaryControls
          span {key: i, className: "control"}, component

  getDefaultProps: ->
    primaryControls: []
    secondaryControls: []
