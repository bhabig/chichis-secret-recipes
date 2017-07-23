$(function() {
  $('#user-recipes').click(function(e) {
    e.preventDefault();
    getUsersRecipes(this)
  });

  function getUsersRecipes(obj) {
    var link = obj.href.slice(21,29);
    $.get(link + '.json', function(response) {
      if(response.recipes.length > 0) {
        $('h3').removeClass('i-hide');
        response.recipes.forEach(function(recipe) {
          var nameTag = '<h4>' + recipe.name.toUpperCase() + '</h4>';
          var picTag =  "<img class='thumb' src='/assets/" + recipe.recipe_avatar + "' alt='Recipe default'></br>";
          var showLinkTag = "<a class='nav-link' href='/users/" + recipe.user_id + "/recipes/" + recipe.id + "'>VIEW RECIPE</a></br>"
          $('#user-recipe-drop').append('<li>'+nameTag+picTag+showLinkTag+'</li>');
        });
      }
    });
  };
});