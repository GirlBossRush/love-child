gulp  = require("gulp")
clean = require("gulp-clean")

gulp.task "clean", ->
  gulp.src("build/", read: false)
    .pipe(clean())
