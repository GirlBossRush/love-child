# A collection of document related methods.

History            = require("ampersand-router/ampersand-history")
_                  = require("underscore")
React              = require("react")
config             = require("../../../config/application")
Exceptions         = require("./document-helper/exceptions")
fullscreenPolyfill = require("./document-helper/fullscreen-polyfill")
d                  = document

DocumentHelper =
  # Sugar.
  navigate: History.navigate.bind(History)

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

# Treat the document title like a property.
Object.defineProperty DocumentHelper, "title",
  # Use base title if no prefix is provided. Arrays will be split and delimited.
  set: (value) ->
    base = config.DEFAULT_TITLE

    title = if value?
      if $.isArray(value)
        prefixes = ""

        for subTitle in value
          prefixes += "#{subTitle} - "

        "#{prefixes}#{base}"
      else
        "#{value} - #{base}"
    else
      base

    d.title = title

  get: ->
    d.title

# Abstract fullscreen API.
Object.defineProperty DocumentHelper, "fullscreen",
  set: (enabled) ->
    if enabled
      d.documentElement.requestFullscreen()
    else
      d.exitFullscreen()

  get: ->
    !!document.fullscreenElement

module.exports = DocumentHelper
