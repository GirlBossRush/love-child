require("coffee-script/register");
var requireDir = require("require-dir");
var gulp       = require("gulp")

requireDir("./gulp/tasks");

defaultTasks = [
  "stylesheets",
  "javascripts",
  "templates",
  "images",
  "fonts",
  "serve",
  "watch"
]

gulp.task("default", defaultTasks);
