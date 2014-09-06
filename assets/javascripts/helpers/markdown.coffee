marked = require("marked")

marked.setOptions
  renderer:    new marked.Renderer()
  sanitize:    true
  gfm:         false
  tables:      false
  breaks:      false
  pedantic:    false
  smartLists:  false
  smartypants: false

module.exports = marked
