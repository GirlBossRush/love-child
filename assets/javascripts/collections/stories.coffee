AmpersandRestCollection = require("ampersand-rest-collection")
Story                   = require("../models/story")
pathHelper              = require("../../../util/path-helper")

Stories = AmpersandRestCollection.extend
  url: pathHelper.api("stories")
  model: Story

module.exports = Stories
