var nextId = 0;
var recipeId;
var userId;
var whatIsThis;

function clickNextRecipe() {
  $('#next-recipe').click(function(e) {
    userId = parseInt($("#next-recipe").attr("data-user-id"));
    getUser(userId);
  });
}

function getUser(userId) {
  $.get("/users/" + userId + ".json", function(data) {
    whatIsThis = data.recipes;
  }).done(function() {
    adjustNextId(whatIsThis);
  });
}

function getRecipe(recipeId) {
  $.get("/users/" + userId + "/recipes/" + recipeId + ".json", function(recipe) {
    $('#recipeName').text(recipe.name.toUpperCase());
    $('#recipeAvatar').html("<img class='profile' src='/assets/" + recipe.recipe_avatar + "' alt='Recipe default'></br>");
    $('#recipeCookTime').text(recipe.cook_time);
    for(let i = 0; i < recipe.ingredients.length; i++) {
      var ingredient = recipe.ingredients[i];
      var measurement = recipe.recipe_ingredients[i].measurement;
      var addLi = "<li><p><a href='/ingredients/" + ingredient.id + "'><strong>" + ingredient.name.toUpperCase() + "</strong></a> <strong>(</strong>" + measurement + "<strong>)</strong></p></li>";
      $('#recipeIngredients').html(addLi);
    }
    $('#recipeInstructions').text(recipe.instructions);
  });
};

function adjustNextId(whatIsThis) {
  if((nextId+1) === whatIsThis.length) {
    nextId = 0;
  } else {
    nextId++;
  }
  recipeId = whatIsThis[`${nextId}`].id;
  getRecipe(recipeId);
}


$(document).ready(clickNextRecipe)
