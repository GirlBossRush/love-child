React                  = require("react")
R                      = React.DOM
HumanTime              = require("../shared/human-time")

module.exports = React.createClass
  displayName: "story"

  render: ->
    R.section {className: "story"},
      R.header {className: "headline"},
        R.div {className: "title"}, @props.story.title
        R.div {className: "description"}, @props.story.description
        R.div {className: "author"}, @props.story.author
        HumanTime {datetime: @props.story.updated_at}
        R.hr {className: "section-seperator"}

      R.article
        className: "body"
        dangerouslySetInnerHTML:
          __html: @props.story.body

      R.footer {className: "summary"}
