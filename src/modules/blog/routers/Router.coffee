AppRouter = require 'AppRouter'
config = require '../config'

url = 'blog'

class Router extends AppRouter
    initialize: (urlPrefix, options) ->
        @controller = options.controller

    appRoutes:
        "": "default"
        "#{url}": "default"

module.exports = Router