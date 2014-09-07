# Placeholder component. Used to fill in loading wait time.

React = require("react")
{div, p, img, section, hr} = React.DOM

{asset}  = require("../../helpers/path")
{sample} = require("underscore")
quotes   = require("../../lib/quotes")

ContentPlaceholder = React.createClass
  displayName: "content-placeholder"

  render: ->
    {body, author} = @state.quote

    section {className: "content-placeholder"},
      img {className: "alternative-fiction-text-logo", src: asset("foundation/text-logo.svg")}
      hr {className: "content-seperator"}

      div {className: "quote"},
        p {className: "quote-body"}, body
        div {className: "quote-author"}, "― #{author}"

  getInitialState: ->
    quote: sample(quotes)

module.exports = ContentPlaceholder
