var nextId;
var recipeId;
var userId;
var whatIsThis = [];

function clickNextRecipe() {
  $('#next-recipe').click(function(e) {
    userId = parseInt($("#next-recipe").attr("data-user-id"));
    getUser(userId);
  });
}

function getUser(userId) {
  $.get("/users/" + userId + ".json", function(data) {
    data.recipes.forEach(function(r) {
      whatIsThis.push(r.id);
    });
  }).done(function() {
    adjustNextId(whatIsThis);
  });
}

function getRecipe(recipeId) {
  $.get("/users/" + userId + "/recipes/" + recipeId + ".json", function(recipe) {
    $('#recipeName').text(recipe.name.toUpperCase());
    $('#recipeAvatar').html(imageFilter(recipe));
    $('#recipeCookTime').text(recipe.cook_time);
    $('#recipeIngredients').html("");
    for(let i = 0; i < recipe.ingredients.length; i++) {
      var ingredient = recipe.ingredients[i];
      var measurement = recipe.recipe_ingredients[i].measurement;
      var addLi = "<li><p><a href='/ingredients/" + ingredient.id + "'><strong>" + ingredient.name.toUpperCase() + "</strong></a> <strong>(</strong>" + measurement + "<strong>)</strong></p></li>";
      $('#recipeIngredients').append(addLi);
    }
    $('#recipeInstructions').text(recipe.instructions);
    likeStatus(recipe);
  });
};

function likeStatus(recipe) {
  if (recipe.likes.length === 0) {
    $(".recipe-like-status").prop('id', 'like-this-recipe');
    $(".recipe-like-status").text("LIKE");
    $(".recipe-like-status").attr('data-recipe-id', recipe.id.toString());
    $(".recipe-like-status").attr('data-user-id', recipe.user_id.toString());
  } else if (recipe.likes[recipe.likes.length - 1].status === false) {
    $(".recipe-like-status").prop('id', 'like-this-recipe');
    $(".recipe-like-status").text("LIKE");
    $(".recipe-like-status").attr('data-recipe-id', recipe.id.toString());
    $(".recipe-like-status").attr('data-user-id', recipe.user_id.toString());
  } else {
    $(".recipe-like-status").prop('id', 'recipe-is-liked');
    $(".recipe-like-status").text("LIKED!");
    $(".recipe-like-status").attr('data-recipe-id', recipe.id.toString());
    $(".recipe-like-status").attr('data-user-id', recipe.user_id.toString());
  }
}

function imageFilter(recipe) {
  if (recipe.recipe_avatar.includes("/system/recipes/")) {
    return "<img class='profile' src='" + recipe.recipe_avatar + "'></br>"
  } else {
    return "<img class='profile' src='/assets/" + recipe.recipe_avatar + "'></br>"
  }
}

function adjustNextId(whatIsThis) {
  if (nextId === undefined) {
    nextId = whatIsThis.indexOf(parseInt($('#next-recipe').attr('data-recipe-id')));
  }
  if((nextId+1) === whatIsThis.length) {
    nextId = 0;
  } else {
    nextId++;
  }
  recipeId = whatIsThis[`${nextId}`];
  getRecipe(recipeId);
}


$(document).ready(clickNextRecipe)
