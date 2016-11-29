template = require './appLayoutView.html'

class AppLayoutView extends Marionette.LayoutView
    el: 'body'
    template: _.template template
    regions:
        header: '.application-header'
        body: '.application-body'


module.exports = AppLayoutView