AmpersandModel     = require("ampersand-model")
_                  = require("underscore")
ContentPlaceholder = require("../components/shared/content-placeholder")
documentHelper     = require("./document-helper")
sync               = AmpersandModel.prototype.sync
fetch              = AmpersandModel.prototype.fetch

module.exports = AmpersandModel.extend
  toJSON: ->
    attributes = {}

    attributes[@name] = @serialize()

    return attributes

  sync: (method, model, options) ->
    if _.contains(["update", "create", "delete"], method)
      options.xhrFields =
        withCredentials: true

    sync.call(this, method, model, options)
