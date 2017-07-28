$(function() {
  $('#user-recipes').click(function(e) {
    e.preventDefault();
    getUsersRecipes(this)
  });
  //COMMENTS ARE FOR CERNAN SPECIFICALLY TO ILLUSTRATE THE CHANGES MADE

  //new constructor function for recipe
  function Recipe(name, picture, id, user_id, formatName, formatPic, formatLink) {
    this.name = name;
    this.picture = picture;
    this.id = id;
    this.user_id = user_id;
    this.formatName = formatName; //formatter?
    this.formatPic = formatPic; //formatter?
    this.formatLink = formatLink; //formatter?
  }

  //NEW...formatter?
  function formatName() {
    return '<h4>' + this.name + '</h4>';
  }

  //used to be called imageFilter(image)...formatter?
  function formatPic() {
    if (this.picture.includes("/system/recipes/")) {
      return "<img class='thumb' src='" + this.picture + "'></br>"
    } else {
      return "<img class='thumb' src='/assets/" + this.picture + "'></br>";
    }
  }

  //NEW...formatter?
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

          //this li variable didn't exist before and was appended directly in the .append() function at the bottom of this // //response function
          var $li = $(document.createElement('li'));

          //this object model prototype is new and is replacing the more 'manual' way of doing it. there is a key for each //trait value and a function for each html element that needed to be created and appended to the recipe <li>
          var buildRecipe = new Recipe(recipe.name.toUpperCase(), recipe.recipe_avatar, recipe.id, recipe.user_id, formatName, formatPic, formatLink);

          //the lines below used to be the lines commented at the bottom of the file
          $li.append(buildRecipe.formatName());
          $li.append(buildRecipe.formatPic());
          $li.append(buildRecipe.formatLink());

          //this used to be: $('#user-recipe-drop').append('<li>' + nameTag + picTag + showLinkTag + '</li>')
          $('#user-recipe-drop').append($li);
        });
      }
    });
  };
});

// NOT USED ANYMORE, USED TO BE IN RESPONSE FUNCTION
// var nameTag = '<h4>' + recipe.name.toUpperCase() + '</h4>';
// var picTag =  imageFilter(recipe);
// var showLinkTag = "<a class='nav-link' href='/users/" + recipe.user_id + "/recipes/" + recipe.id + "'>VIEW RECIPE</a></br>"
