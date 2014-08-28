React                = require("react")
R                    = React.DOM
humanTime            = require("../shared/human-time")
estimatedReadingTime = require("../shared/estimated-reading-time")
documentHelper       = require("../../lib/document-helper")
userPreferences      = require("../users/preferences")
viewControls         = require("./shared/view-controls")
fullscreenToggle     = require("./shared/view-controls/fullscreen-toggle")
htmlToText           = require("html-to-text")

module.exports = React.createClass
  displayName: "story"

  render: ->
    R.section {className: "story"},
      viewControls
        primaryControls: [
          estimatedReadingTime.bind(this, textComponent: @refs.body, text: htmlToText.fromString(@props.story.body) )
          fullscreenToggle
        ]

      R.header {className: "headline"},
        R.div {className: "title", ref: "title", "data-placeholder": "untitled"}, @props.story.title
        R.div {className: "description"}, @props.story.description
        R.div {className: "author"}, @props.story.author
        humanTime {datetime: @props.story.updated_at}
        R.hr {className: "section-seperator"}

      R.article
        ref: "body"
        className: "body"
        "data-width": @state.paragraphWidth
        "data-font-size": @state.paragraphFontSize
        dangerouslySetInnerHTML:
          __html: @props.story.body

      R.footer {className: "summary"}

  componentDidMount: ->
    @setTitle()
    @forceUpdate()

  componentDidUpdate: ->
    @setTitle()

  setTitle: ->
    title = @props.story.title
    documentHelper.title = title?.replace("&nbsp;", "") or "untitled"

  getInitialState: ->
    paragraphFontSize: userPreferences.stories.fontSize
    paragraphWidth: userPreferences.stories.paragraphWidth
