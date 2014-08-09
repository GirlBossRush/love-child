fs          = require("fs")
yaml        = require("js-yaml")
gulp        = require("gulp")
awspublish  = require("gulp-awspublish")

configFile = fs.readFileSync("./config/aws.yml", "utf8")
config     = yaml.safeLoad(configFile)

cacheTime  = 15
headers    =
  "Cache-Control": "max-age=#{cacheTime}, public"

gulp.task "aws-publish", ->
  console.log "Deploying to #{config.bucket}"

  publisher = awspublish.create(config)

  gulp.src("./build/**")
    .pipe(awspublish.gzip(ext: ""))

    .pipe(publisher.publish(headers))

    .pipe(awspublish.reporter())
