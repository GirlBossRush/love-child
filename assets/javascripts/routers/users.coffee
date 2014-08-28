AmpersandRouter = require("ampersand-router/ampersand-router")

react          = require("react")
documentHelper = require("../lib/document-helper")

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
        documentHelper.title = "(#{collection.length}) users"

        documentHelper.render
          component: views.index({collection})

  show: (id) ->
    user = new User({id})

    user.fetch
      success: (model) ->
        documentHelper.title = [model.attributes.title, "users"]

        debugger
        documentHelper.render
          component: views.show(user: model)

  new: ->
    user = new User()
    user.save {body: "hello!"},
      success: (model) ->
        documentHelper.navigate("/users/#{model.id}/edit", true)

  edit: (id) ->
    user = new User({id})

    user.fetch
      success: (model) ->
        documentHelper.title = ["Edit", model.attributes.title, "users"]

        documentHelper.render
          component: views.edit({model})

module.exports = usersRouter
