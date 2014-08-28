React  = require("react")
R      = React.DOM
moment = require("moment")
_      = require("underscore")

WORDS_PER_MINUTE = 250

module.exports = React.createClass
  displayName: "estimated-reading-time"

  render: ->
    words     = @props.words or ""
    wordCount = _.size(words.match(/\s+/g))
    minutes   = wordCount / WORDS_PER_MINUTE

    now       = moment()
    label     = now.add("m", minutes).fromNow(true)
    title     = if wordCount is 1 then "1 word" else "#{wordCount} words"

    R.span {className: "estimated-reading-time", title: title}, label
