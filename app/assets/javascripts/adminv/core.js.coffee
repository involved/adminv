#= require ./ui/core

class @Adminv
  @init = ->
    #Rails.init
    Tables.init()
    #Accordions.init
    #Tabs.init
    #Forms.init
    console.log "Adminv.init [ done ]"

# don't like wrapping Modernizr here, since prevents webfont from starting load before jQuery is ready
jQuery ->
  Modernizr.load
    load: ['http://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js']
    complete: Adminv.init()
