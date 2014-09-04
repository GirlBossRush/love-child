gulp       = require("gulp")
jade       = require("gulp-jade")
config     = require("../../config/application")
meta       = require("../../config/meta-attributes")
{asset}   = require("../../assets/javascripts/helpers/path")

options =
  pretty: config.ENVIRONMENT is "development"
  locals: {config, asset, meta}

gulp.task "templates", ->
  gulp.src "assets/templates/**/*.jade"
    .pipe jade(options)
    .pipe gulp.dest "build"
