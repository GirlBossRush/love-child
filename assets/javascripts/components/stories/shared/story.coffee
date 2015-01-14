React = require("react")
{header, footer, section, article, div, hr} = React.DOM

HumanTime            = require("../../shared/human-time")
EstimatedReadingTime = require("../../shared/estimated-reading-time")
ViewControls         = require("./view-controls")
FullscreenToggle     = require("./view-controls/fullscreen-toggle")
ReadingPreferences   = require("./view-controls/reading-preferences")
userPreferences      = require("../../../helpers/user-preferences")
markdown             = require("../../../helpers/markdown")

module.exports = React.createClass
  displayName: "story"

  render: ->
    {fontSize, paragraphWidth} = userPreferences.stories

    <section className="story">
      <ViewControls
        primaryControls={[
          <EstimatedReadingTime textComponent={@refs.body} trackScrollPosition />
          <FullscreenToggle />
        ]}

        secondaryControls={[
          <ReadingPreferences storyComponent=this />
        ]}
      />

      <header className="selectable headline">
        <div className="title", ref= "title" data-placeholder="untitled">
          {@props.story.title}
        </div>

        <div
          className="selectable description"
          dangerouslySetInnerHTML={{
            __html: markdown(@props.story.description)
          }}
        />

        <div className="author">{@props.story.author}</div>

        <HumanTime datetime={@props.story.updatedAt} />
        <hr className="section-seperator" />
      </header>

      <article
        ref="body"
        className="selectable body"
        data-width={paragraphWidth}
        data-font-size={fontSize}
        dangerouslySetInnerHTML={{
          __html: markdown(@props.story.body)
        }}
      />


      <footer className="summary" />
    </section>

  componentDidMount: ->
    # Update body reference for estimated reading time.
    @forceUpdate()
