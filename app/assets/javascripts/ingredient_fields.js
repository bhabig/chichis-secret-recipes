

  function onClick() {

    $('#click').click(function(e) {
      $.get('/ingredients/new', function(data) {
        $('#fields_for_ingredients').append(data);
      })
      e.preventDefault();

    });

  }
  $(document).ready(onClick)
