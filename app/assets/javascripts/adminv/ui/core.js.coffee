# class Tables
# Basic setup of table classes and fixing column widths
class @Tables
  @init: ->
    new Tables
    console.log("Tables.init [ done ]")
    true

  constructor: ->
    this.addTableIndexClasses()

  addTableIndexClasses: ->
    self = this
    $(".table").each (index, table) ->
      $(this).addClass "table-#{index}"
      self.addColumnIndexClasses(this)
    true

  addColumnIndexClasses: (table) ->
    maximumColumnWidths = [] # handle browsers that don't support table-cell
    $(".row", table).each (index) ->
      $(".col", this).each (index) ->
        maximumColumnWidths[index] = Math.max(maximumColumnWidths[index] || 0, $(this).width())
        $(this).addClass("col-#{index}")

    for index of maximumColumnWidths
      $(".col-#{index}", table).width(maximumColumnWidths[index])

    $(table).addClass('initialized')
    true

# class Tabs
# Basic abstraction of JQ-UI tabs
class @Tabs
  @init: ->
    new Tabs
    console.log("Tabs.init [ done ]")
    true

  constructor: ->
    $(".tabs .block-tabs").parent().tabs();
    true

# class Accordion
class @Accordions
  @init: ->
    new Accordions
    console.log("Accordion.init [ done ]")
    true

  constructor: ->
    $('.accordion-toggle').each ->
      $(this).closest('.row').find('.details').hide();
      $(this).attr(href: 'javascript:void(0)')
      $(this).bind 'click', (event) -> # 'live' handler appears bugged? or I am doing something wrong.
        event.preventDefault()
        $(this).toggleClass 'active'
        $(this).closest('.row').toggleClass('expanded').find('.details').slideToggle(200)
        true
      true
