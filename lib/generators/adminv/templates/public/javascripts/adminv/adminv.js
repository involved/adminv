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
		bindWYMeditor();
		handleRemoveRowLinks();
		handleAddRowLinks();
		bindTableSorter();
		bindDatePicker();
	}

	function bindAccordions() {
		
		// Assign numbers to columns
		$(".table.accordion .row").each(function(index) {
			$(this).children(".col").each(function(index) {
				index++
				$(this).addClass("col"+index);
			});
		});
		
		// Find widest column
		var colnum = 0;
		var colcount = $(".table.accordion .header-group .row").children(".col").length;
		while(colnum < colcount){
			colnum++	
			var arr = $(".col"+colnum).map(function() { return $(this).width() }).get();
			var widest = Math.max.apply( null, arr );
			$(".col"+colnum).width(widest);
		}
		
		// Lock widths
		$(".table.accordion").addClass('initialised')
		
		// Toggling
		var stop = false;
		$(".accordion .accordion-toggle").click(function(event){
			if (stop){
				event.stopImmediatePropagation();
				event.preventDefault();
				stop = false;
			}
		});		
		
		$('.accordion-toggle').live('click', function() {
			$(this).toggleClass("active");
			$(this).closest(".row").toggleClass('expanded').find('.details').slideToggle(200);
			return false;
		}).next(".details").hide();
	}

    function bindTabs(){
        $(".tabs").tabs();
    }
    
	function bindWYMeditor(){
		$("form textarea").wymeditor({
  	      toolsItems: [
		        {'name': 'Bold', 'title': 'Strong', 'css': 'wym_tools_strong'}, 
		        {'name': 'Italic', 'title': 'Emphasis', 'css': 'wym_tools_emphasis'},
		        {'name': 'CreateLink', 'title': 'Link', 'css': 'wym_tools_link'},
		        {'name': 'Unlink', 'title': 'Unlink', 'css': 'wym_tools_unlink'},
		        {'name': 'InsertImage', 'title': 'Image', 'css': 'wym_tools_image'},
		        {'name': 'InsertOrderedList', 'title': 'Ordered_List', 'css': 'wym_tools_ordered_list'},
		        {'name': 'InsertUnorderedList', 'title': 'Unordered_List', 'css': 'wym_tools_unordered_list'},
		        {'name': 'Paste', 'title': 'Paste_From_Word', 'css': 'wym_tools_paste'},
		        {'name': 'Undo', 'title': 'Undo', 'css': 'wym_tools_undo'},
		        {'name': 'Redo', 'title': 'Redo', 'css': 'wym_tools_redo'},
				{'name': 'ToggleHtml', 'title': 'HTML', 'css': 'wym_tools_html'}
		    ]
 		});
		
		$('input[type=submit]').addClass('wymupdate');
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
			var template = $('#' + association + '_fields_template').html();
			var regexp = new RegExp('new_' + association, 'g');
			var new_id = new Date().getTime();
			$('#' + association + '_fields_template').before(template.replace(regexp, new_id));
			if(max_rows == 1){
				$(this).hide();
			}
			bindAccordions();
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

