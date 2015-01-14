# Humanized timestamp component.
# Arguments:
# * datetime: UTC (Unix Epoch)

REFRESH_DELAY = 1000

React  = require("react")
moment = require("moment")

HumanTime = React.createClass
  displayName: "humantime"

  render: ->
    momentInstance = moment(@props.datetime)
    ISOFormatted   = momentInstance.toISOString()

    <time className="human-time" dateTime={ISOFormatted} title={ISOFormatted}>
      {momentInstance.fromNow()}
    </time>

  componentDidMount: ->
    @interval = setInterval(@refresh, REFRESH_DELAY)

  componentWillUnmount: ->
    clearInterval @interval

  refresh: ->
    @forceUpdate()

module.exports = HumanTime
