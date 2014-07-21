gulp    = require("gulp")
gutil   = require("gulp-util")
connect = require("gulp-connect")

assets =
  port: 3000
  root: ["build/assets"]

  # Invalid routes are caught by the client side router.
  fallback: "build/index.html"

  middleware: (connect) ->
    return [
      (req, res, next) ->
        # res.setHeader("Access-Control-Allow-Origin", "http://love-child.com:3000")
        res.setHeader("Access-Control-Allow-Origin", "*")
        res.setHeader("Access-Control-Allow-Methods", "*")
        next()
    ]

gulp.task "serve", ->
  connect.server(assets)
