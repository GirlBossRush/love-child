BackboneVendor = require("backbone-foo/backbone")

vendorNavigate = BackboneVendor.history.navigate

module.exports = (fragment, options) ->
  window.scrollTo(0, 0)

  vendorNavigate.apply(this, arguments)
