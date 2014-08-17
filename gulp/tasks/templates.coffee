gulp       = require("gulp")
jade       = require("gulp-jade")
config     = require("../../config/application")
pathHelper = require("../../util/path-helper")

options =
  pretty: config.ENVIRONMENT is "development"
  locals: {config, pathHelper}

gulp.task "templates", ->
  gulp.src "assets/templates/**/*.jade"
    .pipe jade(options)
    .pipe gulp.dest "build"
