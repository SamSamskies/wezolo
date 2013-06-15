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

  // pick syntax
  // filepicker.pick([options], onSuccess(FPFile){}, onError(FPError){})

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

  // convert syntax
  // filepicker.convert(FPFile, conversion_options, storage_options, onSuccess(FPFile){}, onError(FPError){}, onProgress(percent){})

  fileUploadSuccess: function(FPFile) {
    filepicker.convert(FPFile,
        {width: 230, height: 230, fit:'crop', align:'faces'},

        // To refactor: Couldn't get it to work in a separate function for some reason. Need to pair with someone to figure it out and move this to out to a separate function. Also, need to handle error on conversion.
        function(FPFile) {
          $.post('/avatar_upload', FPFile, function() {
            location.reload();
          });
        }
    );
  },

  // To refactor: Display the error to the user
  fileUploadError: function(FPError){
    console.log(FPError.toString());
  }
};

$(document).ready(function() {
  FilePicker.init();
});

