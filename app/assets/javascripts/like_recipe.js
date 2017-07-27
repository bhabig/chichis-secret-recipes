$(function() {
  $('.recipe-like-status').click(function(e) {
    var userId = parseInt($(this).attr('data-user-id'));
    var recipeId = parseInt($(this).attr('data-recipe-id'));
    var likedOrNot = $(this).attr('id');

    if ( likedOrNot === "recipe-is-liked" ) {
      var likeParams = {
        like: {
          user_id: userId,
          recipe_id: recipeId,
          status: false
        }
      };
    } else if ( likedOrNot === "like-this-recipe" ) {
      var likeParams = {
        like: {
          user_id: userId,
          recipe_id: recipeId,
          status: true
        }
      };
    };

    $.post("/users/" + userId + "/recipes/" + recipeId + "/likes", likeParams).done(function(response) {
      if ( likedOrNot === "like-this-recipe" ) {
        $(".recipe-like-status").prop('id', 'recipe-is-liked');
        $(".recipe-like-status").text("LIKED!");
      } else if ( likedOrNot === "recipe-is-liked" ){
        $(".recipe-like-status").prop('id', 'like-this-recipe');
        $(".recipe-like-status").text("LIKE");
      };
    });
  });
})
