$(document).ready(function(){
  $("#loginModal").on('ajax:error', function(event, xhr, status) {
    $(".alert.alert-error.login-error").text($.parseJSON(xhr.responseText).error);
  });

  $("#loginModal").on('ajax:success', function(event, data) {
    $("#loginModal").modal("hide");
    window.location.replace(data.redirect);
  });

  $("#signupModal").on('ajax:success', function(event, data) {
    $("#signupModal").modal("hide");
    window.location.replace(data.redirect);
  });

  $("#signupModal").on('ajax:error', function(event, xhr, status) {
    $(".alert.alert-error.signup-error").text($.parseJSON(xhr.responseText).error);
  });


  $('.country-filter').change(function() {
    window.location = "/home?query=" + $(this).find('option:selected').text();
  });
  $('.status-filter').change(function() {
    window.location = "/home?query=" + $(this).find('option:selected').text();
  });
  $('.sector-filter').change(function() {
    window.location = "/home?query=" + $(this).find('option:selected').text();
  });

});



