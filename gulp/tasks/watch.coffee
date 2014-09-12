gulp = require "gulp"

tasks =
  "assets/stylesheets/**/*.styl": ["stylesheets"]
  "assets/templates/**/*.jade": ["templates"]
  # Javascripts watched with Watchify.

gulp.task "watch", ["setWatch", "build"], ->
  for match, task of tasks
    gulp.watch(match, task)

