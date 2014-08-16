module.exports =
  UnknownAnchor: (anchor) ->
    @anchor = anchor
    @message = "Unable to find anchor"

    @toString = ->
      "#{@message}: #{@anchor}"

    return
