BackboneVendor = require("backbone-foo/backbone")

vendorSync = BackboneVendor.sync

module.exports = (method, model, options = {}) ->
  # --- Add CSRF token.
  options.beforeSend = (xhr) ->
    token = document.querySelector("meta[name='csrf-token']").content
    console.debug = token
    xhr.setRequestHeader("X-CSRF-Token", token)

  # --- Nest model attributes
  model.vendorToJSON = model.toJSON

  # Override this model instance.
  model.toJSON = ->
    json = {}
    json[model.paramRoot] = model.vendorToJSON()

    return json

  # Call original sync method
  response = vendorSync(method, model, options)

  # restore original toJSON() on this model instance
  model.toJSON = model.vendorToJSON

  return response

