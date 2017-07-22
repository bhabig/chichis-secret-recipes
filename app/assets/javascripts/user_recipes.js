$(function() {
  $('#user-recipes').click(function(e) {
    //debugger;
    getUsersRecipes(this)
    e.preventDefault();
  });

  function getUsersRecipes(obj) {
    $.get(obj.href + '.json', function(response) {
      debugger;
      if(response["recipes"].length > 0) {
        response["recipes"].forEach(function(recipe) {
          debugger;
          //var recipe = `<h4>${recipe["name"]}</h4><p>${}`
        });
      }
    });
  };
});
