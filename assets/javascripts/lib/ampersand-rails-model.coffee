AmpersandModel = require("ampersand-model/ampersand-model")
sync           = require("ampersand-sync")
_              = require("underscore")

module.exports = AmpersandModel.extend
  sync: (method, model, options) ->
    sync.call(this, method, model, options)
