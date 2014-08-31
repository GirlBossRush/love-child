# Humanized timestamp component.
# Arguments:
# * datetime: UTC (Unix Epoch)

REFRESH_DELAY = 1000

React  = require("react")
R      = React.DOM
moment = require("moment")

HumanTime = React.createClass
  displayName: "humantime"

  getInitialState: ->
    {relativeTime: @humanize(@props.datetime)}

  componentDidMount: ->
    @interval = setInterval(@refresh, REFRESH_DELAY)

  componentWillUnmount: ->
    clearInterval @interval

  humanize: (datetime) ->
    moment(datetime).fromNow()

  refresh: ->
    @setState relativeTime: @humanize(@props.datetime)

  render: ->
    ISOFormatted = undefined
    # Component may be rendered before data is ready.
    ISOFormatted = new Date(@props.datetime).toISOString() if @props.datetime

    R.time {className: "human-time", dateTime: @props.datetime, title: ISOFormatted},
      @state.relativeTime

module.exports = HumanTime
