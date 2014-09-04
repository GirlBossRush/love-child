# A collection of document related methods.

fullscreenPolyfill = require("./document-helper/fullscreen-polyfill")

documentHelper = {}

Object.defineProperties documentHelper,
  # Abstract fullscreen API.
  fullscreen:
    set: (enabled) ->
      if enabled
        document.documentElement.requestFullscreen()
      else
        document.exitFullscreen()

    get: ->
      !!document.fullscreenElement

module.exports = documentHelper
