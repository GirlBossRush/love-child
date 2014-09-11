marked   = require("marked")
{extend} = require("lodash")
renderer = new marked.Renderer()
paragraphCounter = 0


# Application specific overrides.
extend renderer,
  heading: (text, level, raw) ->
    id    = @options.headerPrefix + raw.toLowerCase().replace(/[^\w]+/g, '-')
    level = Math.min(level, 2)

    "<h#{level} id='#{id}'>
      #{text}
    </h#{level}>\n"

  paragraph: (text) ->
    paragraphCounter++
    "<p id='paragraph-#{paragraphCounter}'>
      #{text}
    </p>\n"

  list: (body) -> body

  listitem: (text) -> text

  link: (href) -> href

  hr: -> ""

marked.setOptions
  renderer:    renderer
  sanitize:    true
  gfm:         false
  tables:      false
  breaks:      false
  pedantic:    false
  smartLists:  false
  smartypants: false

module.exports = marked
