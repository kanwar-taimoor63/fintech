$(document).on('turbolinks:load',function() {
  var formVisible = localStorage.getItem('signup-form') == 'true'; 
  $('#signup-form').toggle(formVisible);

  $("#signup-btn-id").click(function(){
    $("#signup-form").slideToggle(0, function () {
      localStorage.setItem('signup-form', $('#signup-form').is(':visible')); 
      });
    }); 
});
