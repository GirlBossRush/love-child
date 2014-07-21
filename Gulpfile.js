require("coffee-script/register");
var requireDir = require("require-dir");
var gulp       = require("gulp")

requireDir("./gulp/tasks");

gulp.task("default", ["watch", "serve"]);
