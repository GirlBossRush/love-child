# REFACTOR: Haven't yet found a clean way to pull these variables in.
config = require("../config/application")

if module? and not window?.module?
  # Running within server.
  app_base = config.APP_BASE
  api_base = config.API_BASE
else
  # Running within browser.
  app_base = localStorage["APP_BASE"]
  api_base = localStorage["API_BASE"]

module.exports =
  api: (path = "") ->
    "#{api_base}/#{path}"

  asset: (path = "") ->
    "#{app_base}/assets/#{path}"
