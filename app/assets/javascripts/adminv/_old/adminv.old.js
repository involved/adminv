/*
  Name: Adminv
  URL: https://github.com/jordan-lewis/adminv
  Description: Simple and Clean HTML5 Rails-3 CMS Template.
  Version: 0.1.0
  Author: Jordan Lewis - https://github.com/jordan-lewis
  Author: Nicholas Bruning - https://github.com/thetron
*/

var Adminv = function() {

  function init() {
    updateNoJS();
    ajaxCSRFToken();
    initTables();
    bindAccordions();
    bindTabs();
    //bindMarkdownEditor();
    handleRemoveRowLinks();
    handleAddRowLinks();
    bindTableSorter();
    bindDatePicker();
  }

  function ajaxCSRFToken(){
    $.ajaxSetup({
      beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      }
    });
  }

  function initTypography(){
    loadCustomWebFonts(['BertholdAkzidenzGroteskBEMd'], ['/stylesheets/fonts.css']);
  }

  function updateNoJS(){
    $('.no-js').removeClass('.no-js').addClass('js');
  }

  function initTables() {
    // Assign numbers to tables
    $(".table").each(function(index, table) {
      $(this).addClass("table-" + index);
      initColumns($(this));
    });
  }

  function initColumns(accordion) {
    // Assign numbers to columns
    $(accordion).find(".row").each(function(index) {
      $(this).children(".col").each(function(index) {
        index++
        $(this).addClass("col-"+index);
      });
    });
    
    // Find + set widest column
    var colnum = 0;
    var colcount = $(accordion).find(".header-group .row").children(".col").length;
    /*console.log("col count => " + colcount);*/
    while(colnum < colcount){
      colnum++	
      var arr = $(accordion).find(".col-"+colnum).map(function() { return $(this).width() }).get();
      var widest = Math.max.apply( null, arr );
      $(accordion).find(".col-"+colnum).width(widest);
    }

    // Lock widths
    $(accordion).addClass('initialised')
  }



  function bindTabs(){
    $(".tabs .block-tabs").parent().tabs();
  }

  function bindMarkdownEditor(){
    $("form textarea").not('.basic').markItUp(myMarkdownSettings);
  }

  function handleRemoveRowLinks(){
    $(".remove_row").live('click', function(e){
      e.preventDefault();

      $(this).prev("input[type='hidden']").val("1");
      $(this).closest('.row').fadeOut();
      return false;
    });
  }

  function bindAccordions() {
    $('.accordion-toggle').live('click', function(event) {
      event.preventDefault();
      $(this).toggleClass("active");
      $(this).closest(".row").toggleClass('expanded').find('.details').slideToggle(200);
    }).closest(".row").find(".details").hide();
  }

  function handleAddRowLinks(){
    $(".add_row").click(function(e) {
      e.preventDefault();
      var max_rows = $(this).attr('data-max-rows');
      var association = $(this).attr('data-association');

      if($(this).attr('data-template-target')){
       /* console.log($(this).attr('data-template-target'));*/
        var template = $(this).parents($(this).attr('data-template-target')).html();
      } else {
        var template = $('#' + association + '_fields_template').html();
      }

      var regexp = new RegExp('new_' + association, 'g');
      var new_id = new Date().getTime();

      if($(this).attr('data-target')){
        $($(this).attr('data-target')).append(template.replace(regexp, new_id));
        updatePositions($($(this).attr('data-target')));
      } else {
        $('#' + association + '_fields_template').before(template.replace(regexp, new_id));
      }

      if(max_rows == 1){
        $(this).hide();
      }

      var target_row = $(this).attr('data-target');
      var target_accordion = $(target_row).closest(".accordion.table");
      initColumns(target_accordion);
      return false;
    });
  }

  function updatePositions(wrapper){
    var positions_array = $('.row', wrapper).sortable('toArray');
    $.each(positions_array, function(index, form){
      $("input[id$='_position']", form).attr('value', index);
    });
  }

  function bindTableSorter() {
    $(".table.sortable .row-group").sortable({
      axis: "y",
      items: ".row",
      handle: ".sort-handle",
      placeholder: "row ui-state-highlight",
      start: function(event, ui) {      
        // Add emtpy cells to placeholder row
        var col_count = $(this).find(".row:first").children(".col").length;
        var row_height = $(this).find(".row:first").height();
        var col = 0;
        while(col < col_count){
          col++
          $(".row.ui-state-highlight").append("<div class='col'>&nbsp;</div>");
        }
        $(".row.ui-state-highlight .col").height(row_height-2);
      },
      stop: function(event, ui) {
        updatePositions(this);
        stop = true;
      }
    });
  }

  function bindDatePicker(){
    $(".date-picker").datepicker({
      changeMonth: true,
      changeYear: true,
      showOn: "button",
      buttonImage: "/images/adminv/calendar.gif",
      buttonImageOnly: true
    });
  }

  return {
    init: init
  };

}();

Modernizr.load({
  load: ['http://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js'],
  complete: function(){
    //Adminv.initTypography();
    Modernizr.load({
      load: ['https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js', 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js'],
      complete: Adminv.init
    });
  }
});
