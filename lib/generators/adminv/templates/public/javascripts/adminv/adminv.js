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
	}

	function bindAccordions() {
		var stop = false;
		$(".accordion li .toggle_icon").click(function(event){
			if (stop){
				event.stopImmediatePropagation();
				event.preventDefault();
				stop = false;
			}
		});		
		
		$('.accordion li .toggle_icon').live('click', function() {
			$(this).parent().toggleClass('active').next('.expanded').slideToggle(300);
			return false;
		}).next(".expanded").hide();
	}

    function bindTabs(){
        $(".tabs").tabs();
    }
    
	function bindWYMeditor(){
		$(".wymeditor").wymeditor();
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
		$(".sortable")
			.sortable({
				axis: "y",
				handle: ".sort-handle",
				placeholder: "ui-state-highlight",
				stop: function(event, ui) {				
					/* Keep Zebra Striping uptodate */
					$('.sortable > li').removeClass("even odd");
					$('.sortable > li:nth-child(even)').addClass("even");
					$('.sortable > li:nth-child(odd)').addClass("odd");

					/* Sort each table */
					$('.sortable').each(function(index) {
						var table = $(this).parent(".sudo-table").attr('id');
						var positions_array = $('#' + table + ' .sortable').sortable('toArray');				
						$.each(positions_array, function(index, form) { 
							//console.log("pos:" + index + ", form: " + form);
							$("#" + form + " input.position").attr('value', index);					
						});
						stop = true;
					});
				}
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


















