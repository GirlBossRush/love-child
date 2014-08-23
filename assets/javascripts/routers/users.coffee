AmpersandRouter = require("ampersand-router/ampersand-router")

react          = require("react")
DocumentHelper = require("../lib/document-helper")

User           = require("../models/user")
Users          = require("../collections/users")

views =
  index: require("../components/users/index")

usersRouter = AmpersandRouter.extend
  routes:
    'users(/)': 'index'
    'users/new': 'new'
    'users/:id': 'show'
    'users/:id/edit': 'edit'

  index: ->
    users = new Users()

    users.fetch
      success: (collection) ->
        DocumentHelper.title = "(#{collection.length}) users"

        DocumentHelper.render
          component: views.index({collection})

  show: (id) ->
    user = new User({id})

    user.fetch
      success: (model) ->
        DocumentHelper.title = [model.attributes.title, "users"]

        debugger
        DocumentHelper.render
          component: views.show(user: model)

  new: ->
    user = new User()
    user.save {body: "hello!"},
      success: (model) ->
        DocumentHelper.navigate("/users/#{model.id}/edit", true)

  edit: (id) ->
    user = new User({id})

    user.fetch
      success: (model) ->
        DocumentHelper.title = ["Edit", model.attributes.title, "users"]

        DocumentHelper.render
          component: views.edit({model})

module.exports = usersRouter
