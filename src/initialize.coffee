window.$ = window.jQuery = require 'jquery'
window._ = require 'underscore'
window.Marionette = require 'backbone.marionette'
window.Backbone = require 'backbone'


Application = require './application/Application'

MainModule = require './modules/main/config'


$ ()->
    app = new Application modules: [MainModule]