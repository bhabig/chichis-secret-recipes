var nextId = 0;
var recipeId;
var userId;
var whatIsThis;

$(function() {
  $('#next-recipe').click(function(e) {
    userId = parseInt($("#next-recipe").attr("data-user-id"));
    // GET to user show action which provide's the user's recipe collection to iterate over and give nextId its values
    $.get("/users/" + userId + ".json", function(data) {
      whatIsThis = data.recipes;
      recipeId = whatIsThis[`${nextId+1}`].id;
      getRecipe(recipeId);
      adjustNextId(whatIsThis);
    });

    function adjustNextId(whatIsThis) {
      if(nextId === whatIsThis.length-1) {
        nextId = 0;
      } else if(nextId >= 0 && nextId < whatIsThis.length) {
        nextId++;
      }
    }

    function getRecipe(recipe_id) {
      $.get("/users/" + userId + "/recipes/" + recipeId + ".json", function(recipe) {

      });
    };
  });
});
