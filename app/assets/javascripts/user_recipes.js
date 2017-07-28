$(function() {
  $('#user-recipes').click(function(e) {
    e.preventDefault();
    getUsersRecipes(this)
  });

  function Recipe(name, picture, id, user_id, formatName, formatPic, formatLink) {
    this.name = name;
    this.picture = picture;
    this.id = id;
    this.user_id = user_id;
    this.formatName = formatName;
    this.formatPic = formatPic;
    this.formatLink = formatLink;
  }

  function formatName() {
    return '<h4>' + this.name + '</h4>';
  }

  function formatPic() {
    if (this.picture.includes("/system/recipes/")) {
      return "<img class='thumb' src='" + this.picture + "'></br>"
    } else {
      return "<img class='thumb' src='/assets/" + this.picture + "'></br>";
    }
  }

  function formatLink() {
    return "<a class='nav-link' href='/users/" + this.user_id + "/recipes/" + this.id + "'>VIEW RECIPE</a></br>"
  }


  function getUsersRecipes(obj) {
    var x = obj.href.split('/');
    var link = "/" + x[3] + "/" + x[4]
    $.get(link + '.json', function(response) {
      if(response.recipes.length > 0) {
        $('h3').removeClass('i-hide');
        response.recipes.forEach(function(recipe) {

          var $li = $(document.createElement('li'));
          
          var buildRecipe = new Recipe(recipe.name.toUpperCase(), recipe.recipe_avatar, recipe.id, recipe.user_id, formatName, formatPic, formatLink);

          $li.append(buildRecipe.formatName());
          $li.append(buildRecipe.formatPic());
          $li.append(buildRecipe.formatLink());

          $('#user-recipe-drop').append($li);
        });
      }
    });
  };
});


// var nameTag = '<h4>' + recipe.name.toUpperCase() + '</h4>';
// var picTag =  imageFilter(recipe);
// var showLinkTag = "<a class='nav-link' href='/users/" + recipe.user_id + "/recipes/" + recipe.id + "'>VIEW RECIPE</a></br>"
