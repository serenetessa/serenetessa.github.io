window.$ = window.jQuery = require 'jquery'
window._ = require 'underscore'
window.Marionette = require 'backbone.marionette'
window.Backbone = require 'backbone'


Application = require './application/Application'

MainModule = require './modules/main/config'
AboutModule = require './modules/about/config'
BlogModule = require './modules/blog/config'
PortfolioModule = require './modules/portfolio/config'

$ ()->
    app = new Application modules: [MainModule, AboutModule, BlogModule, PortfolioModule]