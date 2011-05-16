/*
	Name: Adminv
	URL: https://github.com/jordan-lewis/adminv
	Description: Simple and Clean HTML5 Rails-3 CMS Template.
	Version: 0.0.2
	Author: Jordan Lewis - https://github.com/jordan-lewis
	Authod: Nicholas Bruning - https://github.com/thetron
*/


var Adminv = function() {

	function init() {
		bindAccordions();
		bindTabs();
		bindMarkdownEditor();
		handleRemoveRowLinks();
		handleAddRowLinks();
		bindTableSorter();
		bindDatePicker();
	}

	function bindAccordions() {
		var accordion_count = 0;
		
		// Assign numbers to accordions		
		$(".table.accordion").each(function() {
			accordion_count++
			$(this).addClass("group"+accordion_count);
			initAccordion($(this));
		});
		
		// Toggling
		var stop = false;
		$(".accordion .accordion-toggle").live('click', function(event) {
			if (stop){
				event.stopImmediatePropagation();
				event.preventDefault();
				stop = false;
			}
		});		
		
		//$(".accordion-toggle").die("click");
		$('.accordion-toggle').live('click', function() {
			console.log("toggle accordion");
			$(this).toggleClass("active");
			$(this).closest(".row").toggleClass('expanded').find('.details').slideToggle(200);
			return false;
		}).next(".details").hide();
	}

	function initAccordion(accordion) {
		// Assign numbers to columns
		$(accordion).find(".row").each(function(index) {
			$(this).children(".col").each(function(index) {
				index++
				$(this).addClass("col"+index);
			});
		});
		
		// Find + set widest column
		var colnum = 0;
		var colcount = $(accordion).find(".header-group .row").children(".col").length;
		while(colnum < colcount){
			colnum++	
			var arr = $(accordion).find(".col"+colnum).map(function() { return $(this).width() }).get();
			var widest = Math.max.apply( null, arr );
			$(accordion).find(".col"+colnum).width(widest);
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

  function handleAddRowLinks(){
    $(".add_row").click(function(e) {
      e.preventDefault();
      var max_rows = $(this).attr('data-max-rows');
      var association = $(this).attr('data-association');

      if($(this).attr('data-template-target')){
        console.log($(this).attr('data-template-target'));
        var template = $(this).parents($(this).attr('data-template-target')).html();
      } else {
        var template = $('#' + association + '_fields_template').html();
      }

      var regexp = new RegExp('new_' + association, 'g');
      var new_id = new Date().getTime();

      if($(this).attr('data-target')){
        $($(this).attr('data-target')).append(template.replace(regexp, new_id));
      } else {
        $('#' + association + '_fields_template').before(template.replace(regexp, new_id));
      }

      if(max_rows == 1){
        $(this).hide();
      }

			var target_row = $(this).attr('data-target');
			var target_accordion = $(target_row).closest(".accordion.table");
			initAccordion(target_accordion);
      return false;
    });
  }

	function bindTableSorter() {
		$(".table.sortable .row-group").sortable({
			axis: "y",
			handle: ".sort-handle",
			placeholder: "ui-state-highlight",
			stop: function(event, ui) {
				var positions_array = $(".row", this).sortable('toArray');
				$.each(positions_array, function(index, form) { 
					$("input[id$='_position']", form).attr('value', index);
				});
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

/*
 * jQuery DOM ready handler
 */
$(document).ready(function(){
	Adminv.init();	
});

