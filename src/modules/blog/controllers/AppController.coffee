
class AppController extends Marionette.Controller
    initialize: (options)->
        @mainRegion = options.mainRegion

    default: ()->
        console.log 'blog'


module.exports = AppController