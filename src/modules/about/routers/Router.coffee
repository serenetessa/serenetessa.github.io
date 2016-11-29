AppRouter = require 'AppRouter'
config = require '../config'

url = 'about'

class Router extends AppRouter
    initialize: (urlPrefix, options) ->
        @controller = options.controller

    appRoutes:
        "#{url}": "default"

module.exports = Router