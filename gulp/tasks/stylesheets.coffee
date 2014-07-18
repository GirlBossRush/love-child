gulp       = require "gulp"
sass       = require "gulp-ruby-sass"

options =
  style: "expanded"
  precision: 8
  loadPath: [
    "#{process.cwd()}/assets/stylesheets"
    "#{process.cwd()}/node_modules"
    "#{process.cwd()}/vendor/assets/bower_components"
  ]

gulp.task "stylesheets", ->
  gulp.src "assets/stylesheets/application.sass"
    .pipe sass(options)
    .pipe gulp.dest "build/css"
