#= require ./ui/core
#= require ./ui/forms

# class Rails
# Adds some extra jQuery stuff that is otherwise absent (may not be required in 3.1)
class @Rails
  @init = ->
    new Rails
    console.log "Rails.init [ done ]"
    true

  constructor: ->
    this.addCSRFTokenToAJAXRequest()

  addCSRFTokenToAJAXRequest: ->
    $.ajaxSetup beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    true

# class Adminv
# Basic bootstrapping of the rest of the JS
class @Adminv
  @init = ->
    new Adminv
    console.log "Adminv.init [ done ]"
    true

  constructor: ->
    Rails.init()
    Tables.init()
    Tabs.init()
    Accordions.init()
    Forms.init()
    this.updateBodyClass()
    true

  updateBodyClass: ->
    $('.no-js').removeClass('.no-js').addClass('js');
    true

jQuery ->
  Adminv.init()

# YepNope load call
# No external dependencies, so commmented out for now
#Modernizr.load
#  load: ['http://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js']
#  complete: ->
#    jQuery ->
#      Adminv.init()
