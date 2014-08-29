AmpersandRestCollection      = require("ampersand-rest-collection")
ContentPlaceholder           = require("../components/shared/content-placeholder")
documentHelper               = require("./document-helper")
_                            = require("underscore")

fetch = AmpersandRestCollection.prototype.fetch

module.exports = AmpersandRestCollection.extend
  fetch: (options = {}) ->
    _.defaults options,
      preloadContent: ContentPlaceholder

    # Show a given component while fetching content.
    documentHelper.render(component: options.preloadContent())

    fetch.call(this, options)
