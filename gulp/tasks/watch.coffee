gulp   = require "gulp"
tinylr = require "tiny-lr"
server = tinylr()

tasks =
  "assets/stylesheets/**/*.sass": ["stylesheets"]
  "assets/templates/**/*.jade": ["templates"]
  # Javascripts watched with Watchify.

gulp.task "watch", ["setWatch", "build"], ->
  server.listen 35729, (err) ->
    return console.log(err) if err

    for match, task of tasks
      gulp.watch(match, task)

