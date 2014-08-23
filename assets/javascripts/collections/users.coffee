AmpersandRestCollection = require("ampersand-rest-collection/ampersand-rest-collection")
User                    = require("../models/user")
pathHelper              = require("../../../util/path-helper")

Users = AmpersandRestCollection.extend
  url: pathHelper.api("users")
  model: User

module.exports = Users
