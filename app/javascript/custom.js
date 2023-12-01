$(document).ready(function() {
  $('#ingredient-form').submit(function(e) {
    e.preventDefault(); // Empêche la soumission normale du formulaire

    $.ajax({
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      data: new FormData(this),
      processData: false,
      contentType: false,
      success: function(response) {
        // Traitez la réponse ici (éventuellement)
        console.log(response);
      },
      error: function(xhr, status, error) {
        // Gérez les erreurs ici (éventuellement)
        console.error(error);
      }
    });
  });
});
