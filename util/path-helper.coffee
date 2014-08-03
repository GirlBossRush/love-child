config = require("../config/application")

module.exports =
  api: (path = "") ->
    "#{config.API_BASE}/#{path}"

  asset: (path = "") ->
    "#{config.APP_BASE}/assets/#{path}"
