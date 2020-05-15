$(function(){
  // collection_check_boxes用
  $("#modal-fadein-btn").click(function(){
    $(".goals-new__form__category__check-boxes__options-box").fadeIn(100);
  });
  $("#modal-fadeout-btn").click(function(){
    $(".goals-new__form__category__check-boxes__options-box").fadeOut(100);
  });

// 　text_field用
  $(".hidden-field__user-id").attr("name", 'no_user');
  $('.create-category-form').attr("name", 'no_category');
  $(".create-category-form").on("change", function (){
    let input = $(this).val();
    if (input != "") {
      $(this).attr("name", 'goal[categories_attributes][0][category_name]')
      $(".hidden-field__user-id").attr("name", 'goal[categories_attributes][0][user_id]')
    } else {
      $(this).attr("name", 'no_category')
      $(".hidden-field__user-id").attr("name", 'no_user')
    };
  });
});