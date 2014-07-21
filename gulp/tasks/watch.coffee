gulp   = require "gulp"
tinylr = require "tiny-lr"
server = tinylr()

tasks =
  "assets/stylesheets/**/*.sass": ["stylesheets"]
  "assets/javascripts/**/*.coffee": ["javascripts"]
  "assets/templates/**/*.jade": ["templates"]

gulp.task "watch", ->
  server.listen 35729, (err) ->
    return console.log(err) if err

    for match, task of tasks
      gulp.watch(match, task)

