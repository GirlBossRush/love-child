# Estimated reading time component.
# Arguments:
# * text: String. Estimation is based off this.
# * textComponent: React Component. Subtract's scrolled percentage of text if given.

React  = require("react")

moment           = require("moment")
{size, debounce} = require("lodash")

WORDS_PER_MINUTE = 250
SCROLL_THROTTLE  = 500

module.exports = React.createClass
  displayName: "estimated-reading-time"

  render: ->
    return <span className="parent-component-not-ready" /> unless @props.textComponent?

    {minutes, wordCount} = @estimateTimeByText(@props.textComponent.getDOMNode().innerHTML)

    label = if wordCount < WORDS_PER_MINUTE
      "A few seconds" # Very short text.
    else if minutes is 0
      "Finished"
    else
      now = moment()
      now.add("m", minutes).fromNow(true)

    <span className="estimated-reading-time">{label}</span>

  estimateTimeByText: (text = "") ->
    wordCount = size(text.match(/\s+/g))
    minutes   = (wordCount / WORDS_PER_MINUTE) * (1 - @percentageRead())

    return {wordCount, minutes}

  percentageRead: ->
    return 0 unless @props.textComponent?

    $this         = $(window)
    currentY      = $this.scrollTop()
    windowHeight  = $this.height()
    scrollHeight  = $(@props.textComponent.getDOMNode()).height()
    scrollPercent = (currentY / (scrollHeight - windowHeight))

    # Percentage will be higher than 1 if the window is scrolled beyond the element.
    return Math.min(scrollPercent, 1)

  getDefaultProps: ->
    trackScrollPosition: false

  componentDidMount: ->
    return unless @props.trackScrollPosition

    # Calculating scroll position without jQuery is incredibly frustrating.
    # Each browser handles window scrolling dimensions differently.
    # The throttled function must be in a callback because React isn't detecting
    # that an update should be made.

    throttledUpdate = debounce(@forceUpdate.bind(this), SCROLL_THROTTLE)
    $(window).scroll ->
      throttledUpdate()

  componentWillUnmount: ->
    $(window).unbind("scroll")
