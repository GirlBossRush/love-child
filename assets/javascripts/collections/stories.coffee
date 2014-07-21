AmpersandRestCollection = require("ampersand-rest-collection/ampersand-rest-collection")
Story                   = require("../models/story")
apiPath                 = require("../constants").apiPath

Stories = AmpersandRestCollection.extend
  url: apiPath("stories")
  model: Story

module.exports = Stories
