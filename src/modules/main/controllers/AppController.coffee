LandingPageView = require '../views/LandingPageView'

class AppController extends Marionette.Controller
    initialize: (options)->
        @mainRegion = options.mainRegion

    default: ()->
        console.log 'default'
        @landingPageView = new LandingPageView()
        @mainRegion.show @landingPageView


module.exports = AppController