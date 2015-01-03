React = require("react")
{header, footer, section, article, div, hr} = React.DOM

humanTime            = require("../../shared/human-time")
estimatedReadingTime = require("../../shared/estimated-reading-time")
viewControls         = require("./view-controls")
fullscreenToggle     = require("./view-controls/fullscreen-toggle")
readingPreferences   = require("./view-controls/reading-preferences")
userPreferences      = require("../../../helpers/user-preferences")
markdown             = require("../../../helpers/markdown")

module.exports = React.createClass
  displayName: "story"

  render: ->
    {fontSize, paragraphWidth} = userPreferences.stories

    section {className: "story"},
      viewControls
        primaryControls: [
          estimatedReadingTime(textComponent: @refs.body, trackScrollPosition: true)
          fullscreenToggle()
        ]

        secondaryControls: [
          readingPreferences(storyComponent: this)
        ]

      header {className: "selectable headline"},
        div {className: "title", ref: "title", "data-placeholder": "untitled"}, @props.story.title

        div
          className: "selectable description"
          dangerouslySetInnerHTML:
            __html: markdown(@props.story.description)

        div {className: "author"}, @props.story.author

        humanTime {datetime: @props.story.updatedAt}
        hr {className: "section-seperator"}

      article
        ref: "body"
        className: "selectable body"
        "data-width": paragraphWidth
        "data-font-size": fontSize
        dangerouslySetInnerHTML:
          __html: markdown(@props.story.body)

      footer {className: "summary"}

  componentDidMount: ->
    # Update body reference for estimated reading time.
    @forceUpdate()
