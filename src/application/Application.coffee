AppLayoutView = require './AppLayoutView'

class Application extends Marionette.Application
    initialize: (options)->
        @on 'before:start', @startHistory
        @appLayout = new AppLayoutView model: new Backbone.Model options
        @appLayout.render()
        _.each options.modules, (module)=>
             @module module.urlPrefix, module.moduleClass

        @start()

    startHistory: (options) ->
        Backbone.history.start()


module.exports = Application