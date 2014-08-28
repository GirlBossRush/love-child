keyMap = require("../../../lib/key-map")
_      = require("underscore")

module.exports =
  title:
    maxlength: 100
    editKeys: [
      keyMap.backspace
      keyMap.delete
      keyMap.up_arrow
      keyMap.right_arrow
      keyMap.down_arrow
      keyMap.left_arrow
    ]

    init: (title) ->
      self = this

      # ---- Prevent newlines.
      title.addEventListener "keydown", (e) ->
        if e.keyCode is keyMap.enter
          e.preventDefault()

      # ---- Limit length.
      title.addEventListener "keydown", (e) ->
        return if _.contains(self.editKeys, e.keyCode)
        if @textContent.length is self.maxlength
          e.preventDefault()
