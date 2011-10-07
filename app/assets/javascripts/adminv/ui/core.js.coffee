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
