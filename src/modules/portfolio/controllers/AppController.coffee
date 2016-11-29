
class AppController extends Marionette.Controller
    initialize: (options)->
        @mainRegion = options.mainRegion

    default: ()->
        console.log 'portfolio'


module.exports = AppController