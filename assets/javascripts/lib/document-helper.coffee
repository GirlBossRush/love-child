# A collection of document related methods.


History  = require("ampersand-router/ampersand-history")
_        = require("underscore")
React    = require("react")

DocumentHelper =
  # Sugar.
  navigate: History.navigate.bind(History)

  # Components should only be rendered out to an anchor listed here.
  anchors:
    mainContent:  document.getElementById("main-content")
    aboveContent: document.getElementById("above-content")
    asideContent: document.getElementById("aside-content")
    routes: document.getElementById("routes")

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
    base = "Love Child"

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

    document.title = title

  get: ->
    document.title


# --- Exceptions ---

Exceptions =
  UnknownAnchor: (anchor) ->
    @anchor = anchor
    @message = "Unable to find anchor"

    @toString = ->
      "#{@message}: #{@anchor}"

    return

module.exports = DocumentHelper
