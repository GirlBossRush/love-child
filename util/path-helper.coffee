# REFACTOR: Haven't yet found a clean way to pull these variables in.
config = require("../config/application")

if typeof window isnt "undefined"
  config.APP_BASE = document.querySelector("meta[name='APP_BASE']").content
  config.API_BASE = document.querySelector("meta[name='API_BASE']").content

module.exports =
  api: (path = "") ->
    "#{config.API_BASE}/#{path}"

  asset: (path = "") ->
    "#{config.APP_BASE}/assets/#{path}"
