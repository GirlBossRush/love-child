AmpersandRouter = require("ampersand-router/ampersand-router")
documentHelper  = require("../lib/document-helper")
ErrorPage       = require("../components/errors/error-page")

ApplicationRouter = AmpersandRouter.extend
  routes:
    '': 'foundation'
    '*undefined': 'notFound'

  foundation: ->
    documentHelper.title = null

    console.log "foundation"

    documentHelper.render
      component: ErrorPage(code: 204, path: '/')

  notFound: (path) ->
    documentHelper.title = "404 - Error"

    documentHelper.render
      component: ErrorPage({code: 404, path})

module.exports = ApplicationRouter
