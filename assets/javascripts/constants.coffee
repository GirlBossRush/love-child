module.exports =
  apiPath: (path = "") ->
    "//love-child.com:3001/#{path}"

  assetPath: (path = "") ->
    "//love-child.com:3000/#{path}"

  DEFAULT_TITLE: "Love Child"
