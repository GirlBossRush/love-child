argv        = require("yargs").argv
_           = require("underscore")
environment = argv.environment or "development"

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
