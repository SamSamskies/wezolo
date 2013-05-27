$(document).ready(function(){
  $("#loginModal").on('ajax:error', function(event, xhr, status) {
    $(".alert.alert-error.login-error").text($.parseJSON(xhr.responseText).error);
  });

  $("#loginModal").on('ajax:success', function(event, xhr, status) {
    $("#loginModal").modal("hide");
    window.location = "/home";
  });

  $("#signupModal").on('ajax:success', function(event, xhr, status) {
    $("#signupModal").modal("hide");
    window.location.replace("/home");
  });

   $("#signupModal").on('ajax:error', function(event, xhr, status) {
    $(".alert.alert-error.signup-error").text($.parseJSON(xhr.responseText).error);
    // window.location.replace('/');
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

