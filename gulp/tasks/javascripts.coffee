gulp         = require("gulp")
browserify   = require("browserify")
watchify     = require("watchify")
source       = require("vinyl-source-stream")
bundleLogger = require("../util/bundleLogger")
handleErrors = require("../util/handleErrors")

b = browserify({
  entries: ["./assets/javascripts/application.coffee"]
  extensions: [".js", ".coffee"]
  cache: {},
  packageCache: {},
  fullPaths: true
})

bundleAndWatch = ->
  b = watchify(b)
  bundleLogger.start()

  b.on "update", bundleApp.bind(bundleApp, b)

  bundleApp(b)

bundleApp = (b) ->
  b.bundle()
    .on "error", handleErrors
    .on "end", bundleLogger.end
    .pipe(source("application.js"))
    .pipe(gulp.dest("./build/assets/"))

gulp.task "javascripts", ->
  method = if global.isWatching
    bundleAndWatch
  else
    bundleApp.bind(bundleApp, b)

  method()
