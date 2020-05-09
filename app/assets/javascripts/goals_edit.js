$(function(){
  let newCategory = `<li class="new-categories">
                        <input placeholder="複数設定する場合はスペースまたはカンマで区切って下さい" size="60px" class="added-form" type="text" name="no_category" id="goal_categories_attributes_0_category_name">
                    </li>`

  $(".create-new-category-btn").on("click", function(){
    let btn = $(this).text()
    if (btn == "追加") {
      $("ul").append(newCategory)
      $(this).attr("class", "delete-btn").text("削除");
    } else {
      $(".new-categories").remove()
      $(this).attr("class", "create-new-category-btn").text("追加");
    };
  });

  // 　text_field用
  $(document).on("change", ".added-form", function (){
    let input = $(".added-form").val();
    if (input != "") {
      $(".added-form").attr("name", 'goal[categories_attributes][0][category_name]')
    } else {
      $(".added-form").attr("name", 'no_category')
    };
  });
});