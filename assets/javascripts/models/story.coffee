AmpersandModel = require("../lib/ampersand-rails-model")

Story = AmpersandModel.extend
  props:
    id: "integer"
    title: "string"
    description: "string"
    body: "string"
    created_at: "string"
    updated_at: "string"

  urlRoot: "/api/stories"

  defaults:
    title: "Title"

module.exports = Story
