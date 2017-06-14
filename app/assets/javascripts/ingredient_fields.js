
  var counter = 1;

  function onClick() {
    $('#click').click(function(e) {
      $(`#field_${counter}`).removeClass("hidden");
      e.preventDefault();
    });
    counter++;
  }
  $(document).ready(onClick)
