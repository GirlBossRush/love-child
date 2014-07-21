gulp    = require("gulp")
gutil   = require("gulp-util")
connect = require("gulp-connect")
app     = require("express")()

assets =
  port: 3002
  root: ["build/assets"]
  middleware: (connect) ->
    return [
      (req, res, next) ->
        res.setHeader('Access-Control-Allow-Origin', '*')
        res.setHeader('Access-Control-Allow-Methods', '*')
        next()
    ]

gulp.task "serve", ->
  connect.server(assets)

  app.listen 3000, ->
    console.log "Running"

  app.get "*", (req, res, next) ->
    res.sendfile "build/index.html"
