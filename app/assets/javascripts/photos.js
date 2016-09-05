// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {     
  $('a.thumbnail').click(function(e) {
    e.preventDefault();
    var imgPath = $(this).data('imgpath');
    $('#photo-modal img').attr('src', imgPath);
    $("#photo-modal").modal('show');
  });

  $('img').on('click', function() {
    $("#photo-modal").modal('hide')
  });
});