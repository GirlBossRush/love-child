gulp       = require("gulp")
browserify = require("browserify")
watchify   = require("watchify")
source     = require("vinyl-source-stream")
# bundleLogger = require("../util/bundleLogger")
# handleErrors = require("../util/handleErrors")

gulp.task "javascripts", ->
  bundleMethod = (if global.isWatching then watchify else browserify)

  bundler = bundleMethod(
    entries: ["./assets/javascripts/application.coffee"]
    extensions: [".coffee"]
  )

  bundle = ->
    # Log when bundling starts
    # bundleLogger.start()

    bundler
      # Enable source maps.
      .bundle(debug: true)
      # Report compile errors
      # .on("error", handleErrors)
      .pipe(source("application.js"))
      .pipe(gulp.dest("./build/assets"))
      # Log when bundling completes!
      # .on "end", bundleLogger.end

  # Rebundle with watchify on changes.
  bundler.on("update", bundle) if global.isWatching

  bundle()
