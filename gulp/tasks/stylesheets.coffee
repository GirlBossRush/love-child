gulp          = require("gulp")
gulpif        = require("gulp-if")
stylus        = require("gulp-stylus")
minify        = require("gulp-minify-css")
plumber       = require("gulp-plumber")
nib           = require("nib")
handleErrors  = require("../util/handleErrors")

{ENVIRONMENT} = require("../../config/application")
isProduction  = ENVIRONMENT is "production"

options =
  use: [nib()]
  "include css": true
  sourcemap:
    inline: true
  include: [
    "#{process.cwd()}/node_modules"
    "#{process.cwd()}/vendor/assets/stylesheets"
  ]

gulp.task "stylesheets", ->
  gulp.src("assets/stylesheets/application.styl")
    .pipe plumber(errorHandler: handleErrors)
    .pipe stylus(options)
    .pipe gulpif(isProduction, minify(keepSpecialComments: 0))
    .pipe gulp.dest("build/assets")
