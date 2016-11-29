AppController = require './controllers/AppController'
ModuleRouter = require './routers/Router'

class Module extends Marionette.Module
    initialize: (urlPrefix, application)->
        @appController = new AppController mainRegion: application.appLayout.getRegion 'body'
        @router = new ModuleRouter urlPrefix, controller: @appController

module.exports = Module