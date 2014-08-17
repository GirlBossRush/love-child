AmpersandModel = require("../lib/ampersand-rails-model")
pathHelper     = require("../../../util/path-helper")


Story = AmpersandModel.extend
  name: "story"

  props:
    id: "integer"
    title: "string"
    description: "string"
    author: "string"
    body: "string"
    created_at: "string"
    updated_at: "string"

  urlRoot: pathHelper.api("stories")

  defaults:
    title: "Title"

module.exports = Story
