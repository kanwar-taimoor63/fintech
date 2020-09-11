$(document).on('turbolinks:load',function() {
  var formVisible = localStorage.getItem('signup-form') == 'true';
  $('#signup-form').toggle(formVisible);

  $("#signup-btn-id").click(function(){
    $("#signup-form").slideToggle(0, function () {
      localStorage.setItem('signup-form', $('#signup-form').is(':visible'));
      });
    });
  $( "#confirm_password" ).keyup(function() {
    if (document.getElementById('password').value ==
      document.getElementById('confirm_password').value) {
      document.getElementById('message').style.color = 'green';
      document.getElementById('message').innerHTML = 'Matching';
      document.getElementById('submit').disabled = false;
    }
    else {
      document.getElementById('message').style.color = 'red';
      document.getElementById('message').innerHTML = 'Not Matching';
      document.getElementById('submit').disabled = true;
    }
  });
});
