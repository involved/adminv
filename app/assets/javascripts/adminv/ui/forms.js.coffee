class @Forms
  @init: () ->
    new Forms
    console.log("Forms.init [ done ]")
    true

  @updateTableRowPositions: (table) ->
    positionsArray = $('.row', table).sortable('toArray')
    $.each(positionsArray, (index, form) ->
      $("input[id$='_position']", form).attr value: index
    )
    true

  constructor: ->
    console.log("Forms todo")
    true
