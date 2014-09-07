# User preferences object.

class Storage
  constructor: (path, defaultValue) ->
    return {
      get: @get.bind(this, path, "normal")
      set: @set.bind(this, path)
    }

  keyify: (path) ->
    # ["foo bar baz"] => "userPreferences:foo:bar:baz"
    key = "userPreferences:" + path.replace(" ", ":")

  get: (path, _default) ->
    key = @keyify(path)
    localStorage.getItem(key) or _default

  set: (path, value) ->
    key = @keyify(path)
    if !!value
      # Only permit truth values
      localStorage.setItem(key, value)
    else
      localStorage.removeItem(key)

userPreferences =
  stories: {}

Object.defineProperties userPreferences.stories,
  fontSize: new Storage("stories fontSize", "normal")
  paragraphWidth: new Storage("stories, paragraphWidth", "normal")

module.exports = userPreferences
