AmpersandModel = require("ampersand-model/ampersand-model")
sync           = require("ampersand-sync")
_              = require("underscore")

module.exports = AmpersandModel.extend
  sync: (method, model, options) ->
    if _.contains(["update", "create", "delete"], method)
      token = document.querySelector("meta[name='csrf-token']").content

      options.beforeSend = (xhr) ->
        xhr.setRequestHeader("X-CSRF-Token", token)

    sync.call(this, method, model, options)
