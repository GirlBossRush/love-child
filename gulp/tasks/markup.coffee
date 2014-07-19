gulp       = require "gulp"
jade       = require "gulp-jade"

options =
  pretty: true

gulp.task "markup", ->
  gulp.src "assets/markup/index.jade"
    .pipe jade(options)
    .pipe gulp.dest "build"
