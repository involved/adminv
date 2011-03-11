/* Author: Jordan Lewis

*/

var Adminv = function() {

	function init() {
	    bindTabs();
	    changeFormType();
	}

    function bindTabs(){
        $(".tabs").tabs();
    }
    
    function changeFormType(){
        $(".form-stacked").bind('click', function() { 
            $(".form").removeClass("label-inline label-top");
            $(".form").addClass("label-top");
         });
         
         $(".form-inline").bind('click', function() { 
             $(".form").removeClass("label-inline label-top");
             $(".form").addClass("label-inline");
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


















