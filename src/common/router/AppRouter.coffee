class AppRouter extends Marionette.AppRouter
    constructor:  ->
        @listenTo(Backbone.history, 'route', @_onHistoryRoute);
        super(arguments...)

    _onHistoryRoute: (router) ->
        if (this == router)
            @active = true
        else
            @active = false


    execute: (callback, args) ->
        if (!@active)
            this.triggerMethod('before:enter', args);
        this.triggerMethod('before:route', args);
        super(callback, args)

module.exports = AppRouter