template = require './landingPageView.html'
require 'jquery.mousewheel'

class LandingPageView extends Marionette.ItemView
    template: _.template template
    className: 'landing-page-view isAnimated'
    ui:
        'window': '.window'
    events:
        'transitionend': "transitionend"
    animation:
        initial:
            "#Camera": {newClass: 'hide'}
            "#Lamp_on" : {newClass: 'hide'}
        steps: [
            {
                "#Morning_window": {newClass: 'hide'}
            }
            {
                "#Screen_1": {newClass: 'hide'}
            }
            {
                "#Robot": {newClass: 'left30'}
            }
            {
                "#Coffee_cup": {newClass: 'hide left30'}
            }
            {
                "#Camera": {deleteClass: "hide"}
            }
            {
                "#Day_window": {newClass: 'hide'}
            }
            {
                "#Books": {newClass: 'books-transform'}
            }
            {
                "#Screen_2": {newClass: 'hide'}
            }
            {
                "#Lamp_on": {deleteClass: "hide"}
            }
            {
                "#Robot": {newClass: 'left30back'}
            }
            {
                "#Coffee_cup": {newClass: 'left30back'}
            }
            {
                "#Books": {newClass: 'books-transform-back'}
            }
        ]
    initialize: ()->
        @lastItem = null
        @stepIndex = 0
    onRender: ()->
        _.each @animation.initial, (value, key)=>
            @$(key).addClass value.newClass
        setTimeout ()=>
            @goToStep()
        , 200

    transitionend: (e)->
        e.preventDefault()
        if e.target.id != @lastItem
            @lastItem = e.target.id
            @goToStep()

    goToStep: ()->
        _.each @animation.steps[@stepIndex], (value, key)=>
            if value.deleteClass
                @$(key).removeClass value.deleteClass
            if value.newClass
                @$(key).addClass value.newClass
        @stepIndex += 1
        if @stepIndex > @animation.steps.length
            @stepIndex = 0
            console.log 're-initial'
            $('.landing-page-view').removeClass 'isAnimated'
            for i in [@animation.steps.length - 1..0] by -1
                _.each @animation.steps[i], (value, key)=>
                    if value.deleteClass
                        @$(key).addClass value.deleteClass
                    if value.newClass
                        @$(key).removeClass value.newClass
            setTimeout ()=>
                $('.landing-page-view').addClass 'isAnimated'
                @onRender()
            , 300




module.exports = LandingPageView