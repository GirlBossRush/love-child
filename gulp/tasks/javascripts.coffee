gulp         = require("gulp")
ENVIRONMENT  = require("../../config/application").ENVIRONMENT
source       = require("vinyl-source-stream")
_            = require("underscore")

minifyify    = require("minifyify")
browserify   = require("browserify")
watchify     = require("watchify")

bundleLogger = require("../util/bundleLogger")
handleErrors = require("../util/handleErrors")

options =
  entries: ["./assets/javascripts/application.coffee"]
  extensions: [".js", ".coffee"]
  cache: {},
  packageCache: {},

if ENVIRONMENT is "production"
  # Required for Minifyify.
  options.debug = true
else
  # Required for Watchify.
  options.fullPaths = true

b = browserify(options)

b.plugin "minifyify",
  map: "application.map.json"
  output: "./build/assets/application.map.json"
  minify: ENVIRONMENT is "production"

bundleAndWatch = ->
  b = watchify(b)
  b.on "update", bundleApp.bind(bundleApp, b)

  bundleApp(b)

bundleApp = (b) ->
  bundleLogger.start()

  b.bundle()
    .on "error", handleErrors
    .on "end", bundleLogger.end
    .pipe(source("application.js"))
    .pipe(gulp.dest("./build/assets"))

gulp.task "javascripts", ->
  method = if global.isWatching
    bundleAndWatch
  else
    bundleApp.bind(bundleApp, b)

  method()
