gulp        = require("gulp")
runSequence = require("run-sequence")
ENVIRONMENT = require("../../config/application").ENVIRONMENT

gulp.task "deploy", ->
  if ENVIRONMENT is "development"
    throw "Cannot deploy in development environment.
    Assign `NODE_ENV` before running task."

  runSequence("clean", "build", "aws-publish")
