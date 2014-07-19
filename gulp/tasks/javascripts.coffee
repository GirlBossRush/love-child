# browserify task
#   ---------------
#   If the watch task is running, this uses watchify instead
#   of browserify for faster bundling using caching.
#
gulp       = require("gulp")
browserify = require("browserify")
watchify   = require("watchify")
source     = require("vinyl-source-stream")
# bundleLogger = require("../util/bundleLogger")
# handleErrors = require("../util/handleErrors")

gulp.task "javascripts", ->
  bundleMethod = (if global.isWatching then watchify else browserify)

  bundler = bundleMethod(
    # Specify the entry point of your app
    entries: ["./assets/javascripts/application.coffee"]

    # Add file extentions to make optional in your requires
    extensions: [".coffee"]
  )

  bundle = ->
    # Log when bundling starts
    # bundleLogger.start()

    bundler
      # Enable source maps!
      .bundle(debug: true)
      # Report compile errors
      # .on("error", handleErrors)
      # Use vinyl-source-stream to make the
      # stream gulp compatible. Specifiy the
      # desired output filename here.
      .pipe(source("application.js"))
      # Specify the output destination
      .pipe(gulp.dest("./build/assets"))
      # Log when bundling completes!
      # .on "end", bundleLogger.end

  # Rebundle with watchify on changes.
  bundler.on("update", bundle) if global.isWatching

  bundle()
