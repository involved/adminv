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
    this.bindAddRowLinkHandler()
    this.bindRemoveRowLinkHandler()
    true

  enableDatePicker: ->
    $('.date-picker').datepicker(
      changeMonth: true,
      changeYear: true,
      showOn: 'button',
      buttonImage: '/images/adminv/calendar.gif', # not asset pipeline compatible
      buttonImageOnly: true
    )

  bindAddRowLinkHandler: ->
    $('.add_row').click (event) ->
      event.preventDefault()
      maxRows = $(this).attr 'data-max-rows'
      associations = $(this).attr 'data-association'

      if $(this).attr('data-template-target')
        template = $(this).parents($(this).attr('data-template-target')).html()
      else
        template = $("##{association}_fields_template").html()

      regexp = new RegExp "new_#{association}", 'g'
      newID = new Date().getTime()

      if $(this).attr 'data-target'
        $($(this).attr('data-target')).append(template.replace(regexp, newID))
        updatePositions($($(this).attr('data-target')))
      else
        $("##{association}_fields_template").before(template.replace(regexp, newID))

      $(this).hide() if maxRows == 1

      Tables.addColumnIndexClasses $($(this).attr('data-target')).closest('.table')
      false
    true

  bindRemoveRowLinkHandler: ->
    $('.remove_row').live 'click', (event) ->
      event.preventDefault();
      $(this).prev("input[type='hidden']").val("1")
      $(this).closest('.row').fadeOut()
      false
    true
