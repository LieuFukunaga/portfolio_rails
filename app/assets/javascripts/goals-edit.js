$(function(){
  let userId = $("#login-user-id").val();
  let addedCategory = `<li class="added-categories">
                          <input placeholder="複数設定する場合はスペースまたはカンマで区切って下さい" size="60px" class="added-form" type="text" name="no_category" id="goal_categories_attributes_0_category_name">
                          <input value="${userId}" class="added-form-hidden" type="hidden" name="no_user" id="goal_categories_attributes_0_user_id">
                      </li>`

  $("#modal-fadein-btn").click(function(){
    $(".goals-edit__form__category__check-boxes__options-box").fadeIn(100);
  });
  $("#modal-fadeout-btn").click(function(){
    $(".goals-edit__form__category__check-boxes__options-box").fadeOut(100);
  });

  $(document).on("click", "#create-category-btn", function(){
    let btn = $("#create-category-btn").text()
    if (btn == "追加") {
      $("ul").append(addedCategory)
      $("#create-category-btn").attr("class", "delete-btn").text("削除");
    } else {
      $(".added-categories").remove()
      $(this).attr("class", "create-category-btn").text("追加");
    };
  });

  // text_field用
  $(document).on("change", ".added-form", function (){
    let input = $(".added-form").val();
    if (input != "") {
      $(".added-form").attr("name", "goal[categories_attributes][0][category_name]");
      $(".added-form-hidden").attr("name", "goal[categories_attributes][0][user_id]");
    } else {
      $(".added-form").attr("name", 'no_category')
    };
  });
});