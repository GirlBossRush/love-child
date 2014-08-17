fs          = require("fs")
yaml        = require("js-yaml")
gulp        = require("gulp")
awspublish  = require("gulp-awspublish")
ENVIRONMENT = require("../../config/application").ENVIRONMENT

configFile = fs.readFileSync("./config/aws.yml", "utf8")

cacheTime  = 15
headers    = {"Cache-Control": "max-age=#{cacheTime}, public"}

gulp.task "aws-publish", ->
  if ENVIRONMENT is "development"
    throw "Cannot publish files in development environment.
    Assign `NODE_ENV` before running task."

  config = yaml.safeLoad(configFile)[ENVIRONMENT]
  console.log "Deploying to #{config.bucket}"

  publisher = awspublish.create(config)

  gulp.src("./build/**")
    .pipe(awspublish.gzip(ext: ""))

    .pipe(publisher.publish(headers))

    .pipe(awspublish.reporter())
