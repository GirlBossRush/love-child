fs   = require("fs")
yaml = require("js-yaml")
gulp = require("gulp")
_    = require("underscore")

AWS  = require("aws-sdk")
util = require("../util/s3")

configFile    = fs.readFileSync("./config/aws.yml", "utf8")
config        = yaml.safeLoad(configFile)
defaultParams = { Bucket: config.bucket }

_.extend AWS.config,
  region: "us-east-1"
  accessKeyId: config.key
  secretAccessKey: config.secret

gulp.task "aws-clean-bucket", ->
  client = new AWS.S3

  util.fetchObjects client, defaultParams, (objects) ->
    console.log("S3: Removing #{objects.length} objects.")

    deleteParams = _.extend defaultParams,
      Delete:
        Objects: objects

    util.deleteObjects client, deleteParams, ->
      console.log("Cleaned #{config.bucket}.")
