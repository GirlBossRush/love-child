# Application title helper
# Append default title when argument is given.
# Arrays will be split and delimited.

base      = require("../../../config/meta-attributes").title
{isArray} = Array

module.exports = (value) ->
  return base unless value?

  if isArray(value)
    value.join(" - ") + " - #{base}"
  else
    "#{value} - #{base}"
