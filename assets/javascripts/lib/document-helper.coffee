# A collection of document related methods.

History            = require("ampersand-router/ampersand-history")
_                  = require("underscore")
React              = require("react")
config             = require("../../../config/application")
meta               = require("../../../config/meta-attributes")
Exceptions         = require("./document-helper/exceptions")
fullscreenPolyfill = require("./document-helper/fullscreen-polyfill")
d                  = document


documentHelper =
  navigate: (path) ->
    console.log("Navigate: #{path}")
    History.navigate.apply(History, arguments)

  # Components should only be rendered out to an anchor listed here.
  anchors:
    mainContent:  d.getElementById("main-content")
    aboveContent: d.getElementById("above-content")
    asideContent: d.getElementById("aside-content")

  render: (options = {}) ->
    _.defaults options,
      props: {}
      anchor: "mainContent"

    anchor = @anchors[options.anchor]

    if anchor
      React.renderComponent options.component, anchor
    else
      throw new Exceptions.UnknownAnchor(options.anchor)

Object.defineProperties documentHelper,
  # Treat the document title like a property.
  title:
    set: (value) ->
      # Use base title if no prefix is provided. Arrays will be split and delimited.
      base = meta.title

      title = if value?
        if Array.isArray(value)
          prefixes = ""

          value.join(" - ") + " - #{base}"
        else
          "#{value} - #{base}"
      else
        base

      d.title = title

    get: ->
      d.title

  # Abstract fullscreen API.
  fullscreen:
    set: (enabled) ->
      if enabled
        d.documentElement.requestFullscreen()
      else
        d.exitFullscreen()

    get: ->
      !!document.fullscreenElement

module.exports = documentHelper
