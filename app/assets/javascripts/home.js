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
    window.location = "/home?query_string=" + $(this).find('option:selected').val() + "&query_type=country";
  });

  $('div.news-container').infinitescroll({
    navSelector  : "div.pagination",
    // selector for the paged navigation (it will be hidden)
    nextSelector : "div.pagination a.next_page",
    // selector for the NEXT link (to page 2)
    itemSelector : ".form-effects.form-margins.span10"
    // selector for all items you'll retrieve
  });


});



