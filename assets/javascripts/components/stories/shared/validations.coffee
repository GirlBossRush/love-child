key        = require("../../../lib/key-map")
{contains} = require("underscore")

module.exports =
  title:
    maxlength: 100
    editKeys: [
      key.backspace
      key.delete
      key.up_arrow
      key.right_arrow
      key.down_arrow
      key.left_arrow
    ]

    init: (title) ->
      self = this

      # ---- Prevent newlines.
      title.addEventListener "keydown", (e) ->
        if e.keyCode is key.enter
          e.preventDefault()

      # ---- Limit length.
      title.addEventListener "keydown", (e) ->
        return if contains(self.editKeys, e.keyCode)
        if @textContent.length is self.maxlength
          e.preventDefault()
