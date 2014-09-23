gulp = require "gulp"

tasks =
  "assets/stylesheets/**/*.styl": ["stylesheets"]
  "assets/templates/**/*.jade": ["templates"]
  "assets/images/**/*": ["images"]
  "assets/fonts/**/*": ["fonts"]
  # Javascripts watched with Watchify.

gulp.task "watch", ["setWatch", "build"], ->
  for match, task of tasks
    gulp.watch(match, task)

