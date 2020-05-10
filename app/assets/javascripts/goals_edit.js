$(function(){
  let category_index = $(".edit-category__jquery").length

  let addedCategory = `<li class="added-categories">
                        <input placeholder="複数設定する場合はスペースまたはカンマで区切って下さい" size="60px" class="added-form" type="text" name="no_category" id="goal_categories_attributes_${category_index}_category_name">
                    </li>`

  $("#modal-fadein-btn").click(function(){
    $(".goals-edit__form__category__check-boxes__options-box").fadeIn(100);
  });
  $("#modal-fadeout-btn").click(function(){
    $(".goals-edit__form__category__check-boxes__options-box").fadeOut(100);
  });

  $("#create-category-btn").on("click", function(){
    let btn = $("#create-category-btn").text()
    if (btn == "追加") {
      $("ul").append(addedCategory)
      $(this).attr("class", "delete-btn").text("削除");
    } else {
      $(".added-categories").remove()
      $(this).attr("class", "create-category-btn").text("追加");
    };
  });

  // 　text_field用
  $(document).on("change", ".added-form", function (){
    let input = $(".added-form").val();
    if (input != "") {
      $(".added-form").attr("name", `goal[categories_attributes][${category_index}][category_name]`)
    } else {
      $(".added-form").attr("name", 'no_category')
    };
  });
});