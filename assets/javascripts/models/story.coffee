AmpersandModel = require("../lib/ampersand-rails-model")
apiPath        = require("../constants").apiPath

Story = AmpersandModel.extend
  name: "story"

  props:
    id: "integer"
    title: "string"
    description: "string"
    body: "string"
    created_at: "string"
    updated_at: "string"

  urlRoot: apiPath("stories")

  defaults:
    title: "Title"

module.exports = Story
