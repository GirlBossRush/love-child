fs          = require("fs")
yaml        = require("js-yaml")
gulp        = require("gulp")
{extend}    = require("lodash")
ENVIRONMENT = require("../../config/application").ENVIRONMENT
AWS         = require("aws-sdk")
util        = require("../util/s3")

configFile    = fs.readFileSync("./config/aws.yml", "utf8")

gulp.task "aws-clean-bucket", ->
  if ENVIRONMENT is "development"
    throw "Cannot clean bucket files in development.
    Assign `NODE_ENV` before running task."

  config        = yaml.safeLoad(configFile)[ENVIRONMENT]
  defaultParams = { Bucket: config.bucket }

  extend AWS.config,
    region: "us-east-1"
    accessKeyId: config.key
    secretAccessKey: config.secret

  client = new AWS.S3

  util.fetchObjects client, defaultParams, (objects) ->
    console.log("S3: Removing #{objects.length} objects.")

    deleteParams = extend defaultParams,
      Delete:
        Objects: objects

    util.deleteObjects client, deleteParams, ->
      console.log("Cleaned #{config.bucket}.")
