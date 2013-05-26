$(document).ready(function(){
  $("#loginModal").on('ajax:error', function(event, xhr, status) {
    $(".alert.alert-error").text($.parseJSON(xhr.responseText).error);
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
    $(".alert.alert-error").text($.parseJSON(xhr.responseText).error);
    // window.location.replace('/');
  });

});

