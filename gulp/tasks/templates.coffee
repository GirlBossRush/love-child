gulp       = require("gulp")
jade       = require("gulp-jade")
constants  = require("../../assets/javascripts/constants")

options =
  pretty: true
  locals: constants

gulp.task "templates", ->
  gulp.src "assets/templates/**/*.jade"
    .pipe jade(options)
    .pipe gulp.dest "build"
