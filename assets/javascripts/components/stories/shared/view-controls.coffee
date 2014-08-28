React          = require("react")
R              = React.DOM

module.exports = React.createClass
  displayName: "view-controls"

  render: ->
    R.aside {className: "view-controls"},
      R.section {className: "primary-controls"},
        @props.primaryControls.map (component) ->
          component()
