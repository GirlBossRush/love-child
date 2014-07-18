AmpersandRestCollection = require("ampersand-rest-collection/ampersand-rest-collection")
Story = require("../models/story")

Stories = AmpersandRestCollection.extend
  url: '/api/stories'
  model: Story

module.exports = Stories
