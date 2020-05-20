$(function(){
  // 画像アップロード時のプレビュー表示のため
  function buildImg (blobUrl){
    let html = `<img src="${blobUrl}" id="goals-edit__new-image-preview">`
    return html;
  }

  function appendFileField () {
    let fileField = `<input id="goals-edit__file-field" type="file" name="goal[image]">`
    $(".goals-edit__form__text-field__icons__upload__label").append(fileField);
  }


  $(".goals-edit__form__text-field__icons__upload").on("change", "#goals-edit__file-field", function(e){
    $(".goals-edit__form__image__previews__new-image").empty();
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);
    $('.goals-edit__form__image__previews__new-image').append(buildImg(blobUrl));
  })

  $("#goals-edit__remove-preview-btn").click(function(){
    $(".goals-edit__form__image__previews__new-image").empty();
    $("#goals-edit__file-field").remove();
    appendFileField();
  })




  let userId = $("#login-user-id").val();
  let addedCategory = `<li class="added-categories">
                          <input placeholder="複数の場合はspaceまたはカンマで区切って下さい" size="45px" class="added-form" type="text" name="no_category" id="goal_categories_attributes_0_category_name">
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
      $(".added-form-hidden").attr("name", "no_user");
    };
  });
});