$(document).on('turbolinks:load',function() {
  
  var formVisible = localStorage.getItem('signup-form') == 'true'; 
  $('#signup-form').toggle(formVisible);
  var CustomerInfoVisible = localStorage.getItem('customer-info-card') == 'true'; 
  $('#customer-info-card').toggle(CustomerInfoVisible);
  var PaymentVisible = localStorage.getItem('payment-card') == 'true'; 
  $('#payment-card').toggle(PaymentVisible);


  $("#signup-btn-id").click(function(){
    $("#signup-form").slideToggle(0, function () {
      localStorage.setItem('signup-form', $('#signup-form').is(':visible')); 
      });
    }); 
  $("#checkout-btn").click(function(){
    $("#customer-info-card").show( function () {
      localStorage.setItem('customer-info-card', $('#customer-info-card').is(':visible')); 
      });
    });
  $("#customer-info-btn").click(function(){
    $("#payment-card").show( function () {
      localStorage.setItem('payment-card', $('#payment-card').is(':visible')); 
      });
    });

});
