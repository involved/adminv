# Adminv Javascript Manifest
#= require_self
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require modernizr
#= require ./log
#= require ./core

# Allows function and object namespaces
root = exports ? this
root.namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top
