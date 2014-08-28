AmpersandRouter = require("ampersand-router/ampersand-router")

react          = require("react")
documentHelper = require("../lib/document-helper")

Story          = require("../models/story")
Stories        = require("../collections/stories")

views =
  index: require("../components/stories/index")
  show:  require("../components/stories/show")
  edit:  require("../components/stories/edit")

StoriesRouter = AmpersandRouter.extend
  routes:
    'stories(/)': 'index'
    'stories/new': 'new'
    'stories/:id': 'show'
    'stories/:id/edit': 'edit'

  index: ->
    stories = new Stories()

    stories.fetch
      success: (collection) ->
        documentHelper.title = "(#{collection.length}) Stories"

        documentHelper.render
          component: views.index({collection})

  show: (id) ->
    story = new Story({id})

    story.fetch
      success: (model) ->
        documentHelper.render
          component: views.show(story: model)

  new: ->
    story = new Story()
    story.save {body: "hello!"},
      success: (model) ->
        documentHelper.navigate("/stories/#{model.id}/edit", true)

  edit: (id) ->
    story = new Story({id})

    story.fetch
      success: (model) ->
        documentHelper.render
          component: views.edit({model})

module.exports = StoriesRouter
