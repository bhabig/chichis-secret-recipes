$(function() {
  $('.like-this-recipe').click(function(e) {
    var userId = parseInt($(this).attr('data-user-id'));
    var recipeId = parseInt($(this).attr('data-recipe-id'));
    var likeParams = {
      like: {
        user_id: userId,
        recipe_id: recipeId
      }
    };
    $.post("/users/" + userId + "/recipes/" + recipeId + "/likes", likeParams).done(function(response) {
      if($(this).is('#recipe-is-liked')) {
        $(this).removeProp('id', 'recipe-is-liked');
        $(this).text("LIKE");
      } else {
        $(this).prop('id', 'recipe-is-liked');
        $(this).text("LIKED!");
      }
    });
  });
})
