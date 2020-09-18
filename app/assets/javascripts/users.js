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

  $("#checkout-btn").click(function(){
    $("#customer-info-card").show( function () {
      localStorage.setItem('customer-info-card', $('#customer-info-card').is(':visible'));
      });
    });
  $("#customer-info-btn").click(function(){
    var w = document.getElementById("firstname-field").value;
    var x = document.getElementById("lastname-field").value;
    var y = document.getElementById("email-field").value;
    var z = document.getElementById("address-field").value;

    if (x === "" || w==="" || y==="" || z==="") {
        return;
    }
    $("#payment-card").show( function () {
      localStorage.setItem('payment-card', $('#payment-card').is(':visible'));
      });
    });

    $("#payment-btn").click(function(){

      $("#customer-info-card").hide();
      $("#payment-card").hide();
      $("#summary-card").hide();
      $("#confirmation-card").show( function () {
        localStorage.setItem('confirmation-card', $('#confirmation-card').is(':visible'));
      });

    });

  $('.ckeditor').ckeditor({
    
  });





});
