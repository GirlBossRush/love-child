_ = require("underscore")

environment = if window?
  # Running within browser.
  localStorage["ENVIRONMENT"]
else
  # Running within server.
  process.env.NODE_ENV or "development"

config =
  DEFAULT_TITLE: "Alternative Fiction"
  ENVIRONMENT: environment

environmentConfig = switch environment
  when "development"
    require("./environments/development")
  when "production"
    require("./environments/production")
  else
    throw "Unknown environment: #{environment}"

_.extend(config, environmentConfig)

module.exports = config
