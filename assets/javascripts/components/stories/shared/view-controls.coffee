React = require("react")

module.exports = React.createClass
  displayName: "view-controls"

  render: ->
    <aside className="view-controls no-mobile no-print">
      <section className="primary-controls">{
        for component, i in @props.primaryControls
          <span key={i} className="control">{component}</span>
      }</section>

      <section className="secondary-controls">{
        for component, i in @props.secondaryControls
          <span key={i} className="control">{component}</span>
      }</section>
    </aside>

  getDefaultProps: ->
    primaryControls: []
    secondaryControls: []
