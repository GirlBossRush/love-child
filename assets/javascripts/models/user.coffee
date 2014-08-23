AmpersandModel = require("../lib/ampersand-rails-model")
pathHelper     = require("../../../util/path-helper")

User = AmpersandModel.extend
  name: "user"

  props:
    id: "string"
    email: "string"
    description: "string"
    last_login: "string"
    last_activity: "string"
    created_at: "string"
    updated_at: "string"

  urlRoot: pathHelper.api("users")

  defaults:
    name: "Anonymous"

module.exports = User
