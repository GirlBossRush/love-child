# Placeholder component. Used to fill in loading wait time.

React = require("react")

{asset}  = require("../../helpers/path")
{sample} = require("lodash")
quotes   = require("../../lib/quotes")

ContentPlaceholder = React.createClass
  displayName: "content-placeholder"

  render: ->
    {body, author} = @state.quote

    <section className="content-placeholder">
      <img className="alternative-fiction-text-logo" src={asset("foundation/text-logo.svg")} />
      <hr className="content-seperator" />

      <div className="quote">
        <p className="quote-body">{body}</p>
        <div className="quote-author">{"― #{author}"}</div>
      </div>
    </section>

  getInitialState: ->
    quote: sample(quotes)

module.exports = ContentPlaceholder
