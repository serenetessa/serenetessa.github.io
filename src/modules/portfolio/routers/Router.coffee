AppRouter = require 'AppRouter'
config = require '../config'

url = 'portfolio'

class Router extends AppRouter
    initialize: (urlPrefix, options) ->
        @controller = options.controller

    appRoutes:
        "": "default"
        "#{url}": "default"

module.exports = Router