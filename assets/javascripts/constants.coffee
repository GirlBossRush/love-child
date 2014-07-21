module.exports =
  apiPath: (path = "") ->
    "//love-child.com:3001/#{path}"

  assetPath: (path = "") ->
    "//assets.love-child.com:3002/#{path}"

  DEFAULT_TITLE: "Love Child"
