AmpersandModel = require("ampersand-model/ampersand-model")
sync           = require("ampersand-sync")
_              = require("underscore")

module.exports = AmpersandModel.extend
  sync: (method, model, options) ->
    options.beforeSend = (xhr) ->
      xhr.setRequestHeader("Access-Control-Allow-Origin", "http://love-child:3001")
      xhr.setRequestHeader("Access-Control-Allow-Methods", "http://love-child:3001")

    sync.call(this, method, model, options)
