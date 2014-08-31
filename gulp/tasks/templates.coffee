gulp       = require("gulp")
jade       = require("gulp-jade")
config     = require("../../config/application")
meta       = require("../../config/meta-attributes")
pathHelper = require("../../assets/javascripts/lib/path-helper")

options =
  pretty: config.ENVIRONMENT is "development"
  locals: {config, pathHelper, meta}

gulp.task "templates", ->
  gulp.src "assets/templates/**/*.jade"
    .pipe jade(options)
    .pipe gulp.dest "build"
