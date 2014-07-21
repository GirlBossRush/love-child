gulp = require("gulp")

gulp.task "fonts", ->
  gulp.src "assets/fonts/**/*"
    .pipe gulp.dest "build/assets"
