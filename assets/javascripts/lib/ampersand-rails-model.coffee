AmpersandModel = require("ampersand-model/ampersand-model")
sync           = require("ampersand-sync")
_              = require("underscore")

AmpersandModel.prototype.toJSON = ->
  attributes = {}

  attributes[@name] = @serialize()

  return attributes

AmpersandModel.prototype.sync = (method, model, options) ->
  if _.contains(["update", "create", "delete"], method)
    options.xhrFields =
      withCredentials: true

  sync.call(this, method, model, options)

module.exports = AmpersandModel
