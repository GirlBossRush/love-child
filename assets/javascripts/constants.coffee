module.exports =
  apiPath: (path = "") ->
    "http://love-child.com:3001/#{path}"

  assetPath: (path = "") ->
    "http://love-child.com:3000/#{path}"

  DEFAULT_TITLE: "Love Child"
