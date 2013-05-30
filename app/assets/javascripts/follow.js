var Follow = {
  init: function() {
    $(".container.search-index").on('ajax:success', 'a.follow-btn',this.changeFollow);
    $(".container.search-index").on('ajax:error', 'a.follow-btn',this.appendErrors);
  },

  changeFollow: function(event, data, status, xhr) {
    $(this).replaceWith(data.link)
  },
  
  // refactoring required
  appendErrors: function(event, xhr, status, error) {
    $(this).before($.parseJSON(xhr.responseText).error);
  }
}

$(document).ready(function() {
  Follow.init();
})
