AmpersandRouter = require("ampersand-router/ampersand-router")
DocumentHelper  = require("../lib/document-helper")
ErrorPage       = require("../components/errors/error-page")

ApplicationRouter = AmpersandRouter.extend
  routes:
    '': 'foundation'
    '*undefined': 'notFound'

  foundation: ->
    DocumentHelper.title = null

    console.log "foundation"

    DocumentHelper.render
      component: ErrorPage(code: 204, path: '/')

  notFound: (path) ->
    DocumentHelper.title = "404 - Error"

    DocumentHelper.render
      component: ErrorPage({code: 404, path})

module.exports = ApplicationRouter
