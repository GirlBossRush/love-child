React               = require("react")
R                   = React.DOM
humanTime           = require("../shared/human-time")
estimateReadingTime = require("../shared/estimate-reading-time")
DocumentHelper      = require("../../lib/document-helper")
viewControls        = require("./show/view-controls")

module.exports = React.createClass
  displayName: "story"

  render: ->
    R.section {className: "story"},
      viewControls(@props.story)

      R.header {className: "headline"},
        R.div {className: "title"}, @props.story.title
        R.div {className: "description"}, @props.story.description
        R.div {className: "author"}, @props.story.author
        humanTime {datetime: @props.story.updated_at}
        estimateReadingTime {words: @state.bodyText}
        R.hr {className: "section-seperator"}

      R.article
        ref: "body"
        className: "body"
        "data-paragraph-width": @state.paragraphWidth
        "data-paragraph-font-size": @state.paragraphWidth
        dangerouslySetInnerHTML:
          __html: @props.story.body

      R.footer {className: "summary"}

  componentDidMount: ->
    # Body text can be extracted from the initial HTML string after mounting.
    body            = @refs.body.getDOMNode()
    @state.bodyText = body.textContent
    @forceUpdate()

  getInitialState: ->
    paragraphFontSize: "default"
    paragraphWidth: "default"
    bodyText: ""
