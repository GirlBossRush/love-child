argv = require("yargs").argv

module.exports =
  APP_BASE: do ->
    if argv.environment is "production"
      "//alternativefiction.org"
    else
      "//localhost:3000"

  API_BASE: do ->
    if argv.environment is "production"
      "//api.alternativefiction.org"
    else
      "//localhost:3001"

  DEFAULT_TITLE: "Alternative Fiction"
