var FilePicker = {
  init: function() {
    this.addListeners();
  },

  addListeners: function() {
    var self = this;
    $('#upload').on('click', function(e) {
      e.preventDefault();
      self.openFilePicker();
    });
  },

  openFilePicker: function() {
    this.setFileKey();
    filepicker.pick({
      mimetypes: ['image/*'],
      container: 'window',
      services: ['COMPUTER', 'FACEBOOK', 'INSTAGRAM']
    }, this.fileUploadSuccess, this.fileUploadError);
  },

  setFileKey: function() {
    filepicker.setKey('AgJwiTpW6Q8KoyO5GxeNQz');
  },

  fileUploadSuccess: function(FPFile) {
    $.post('/avatar_upload', FPFile, function() {
      location.reload();
    });
  },

  fileUploadError: function(FPError){
    console.log(FPError.toString());
  }
};

$(document).ready(function() {
  FilePicker.init();
});

