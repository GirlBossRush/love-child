gulp         = require("gulp")
sass         = require("gulp-ruby-sass")
ENVIRONMENT  = require("../../config/application").ENVIRONMENT


options =
  style: "expanded"
  lineNumbers: true
  precision: 8
  loadPath: [
    "#{process.cwd()}/assets/stylesheets"
    "#{process.cwd()}/node_modules"
    "#{process.cwd()}/vendor/assets/stylesheets"
    "#{process.cwd()}/vendor/assets/bower_components"
  ]

if ENVIRONMENT is "production"
  options.style     = "compressed"
  options.sourcemap = true

gulp.task "stylesheets", ->
  gulp.src "assets/stylesheets/application.sass"
    .pipe sass(options)
    .pipe gulp.dest "build/assets"
