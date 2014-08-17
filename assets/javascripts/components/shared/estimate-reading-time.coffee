React               = require("react")
R                   = React.DOM
moment              = require("moment")
estimateReadingTime = require("../../lib/estimate-reading-time")

WORDS_PER_MINUTE = 250

module.exports = React.createClass
  displayName: "estimate-reading-time"

  render: ->
    words     = @props.words
    wordCount = (words.match(/\s+/g) or 0).length
    minutes   = wordCount / WORDS_PER_MINUTE

    now       = moment()
    label     = now.add("m", minutes).fromNow(true)
    title     = if wordCount is 1 then "1 word" else "#{wordCount} words"

    R.span {className: "estimated-reading-time", title: title}, label
