gulp        = require("gulp")
runSequence = require("run-sequence")

gulp.task "deploy", ->
  runSequence("clean", "build", "aws-publish")
