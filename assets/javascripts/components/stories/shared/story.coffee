React = require("react")
{header, footer, section, article, div, hr} = React.DOM

humanTime            = require("../../shared/human-time")
estimatedReadingTime = require("../../shared/estimated-reading-time")
userPreferences      = require("../../users/preferences")
viewControls         = require("./view-controls")
fullscreenToggle     = require("./view-controls/fullscreen-toggle")
htmlToText           = require("html-to-text")
markdown             = require("../../../helpers/markdown")

module.exports = React.createClass
  displayName: "story"

  render: ->
    section {className: "story"},
      viewControls
        primaryControls: [
          estimatedReadingTime(textComponent: @refs.body, text: htmlToText.fromString(@props.story.body))
          fullscreenToggle()
        ]

      header {className: "headline"},
        div {className: "title", ref: "title", "data-placeholder": "untitled"}, @props.story.title

        div
          className: "description"
          dangerouslySetInnerHTML:
            __html: markdown(@props.story.description)

        div {className: "author"}, @props.story.author

        humanTime {datetime: @props.story.updatedAt}
        hr {className: "section-seperator"}

      article
        ref: "body"
        className: "body"
        "data-width": @state.paragraphWidth
        "data-font-size": @state.paragraphFontSize
        dangerouslySetInnerHTML:
          __html: markdown(@props.story.body)

      footer {className: "summary"}

  componentDidMount: ->
    # Update body reference for estimated reading time.
    @forceUpdate()

  getInitialState: ->
    paragraphFontSize: userPreferences.stories.fontSize
    paragraphWidth: userPreferences.stories.paragraphWidth
