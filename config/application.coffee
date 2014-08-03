argv        = require("yargs").argv
environment = argv.environment or "development"

module.exports =
  DEFAULT_TITLE: "Alternative Fiction"

  ENVIRONMENT: environment

  APP_BASE: if environment is "production"
    "//alternativefiction.org"
  else
    "//localhost:3000"

  API_BASE: if environment is "production"
    "//api.alternativefiction.org"
  else
    "//localhost:3001"
