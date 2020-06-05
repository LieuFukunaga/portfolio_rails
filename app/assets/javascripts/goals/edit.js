$(function(){
  // hidden-fieldの１つのvalue属性を取得
  let userId = $("#login-user-id").val();

  let addedCategory = `<li class="added-categories">
                          <input placeholder="複数の場合はspaceまたはカンマで区切って下さい" class="added-form" type="text" name="no_category" id="goal_categories_attributes_0_category_name">
                          <input value="${userId}" class="added-form-hidden" type="hidden" name="no_user" id="goal_categories_attributes_0_user_id">
                      </li>`



  // 画像アップロード時のプレビュー表示のため
  function buildImg (blobUrl){
    let html = `<div class="goals-edit__change-image-icon">
                  <i class="fas fa-angle-double-right"></i>
                </div>
                <div class="goals-edit__new-image">
                  <img src="${blobUrl}" class="goals-edit__new-image-preview">
                </div>`
    return html
  }

  function buildFileField () {
    let fileField = `<input class="goals-edit__form__file-field" type="file" name="goal[image]">`
    return fileField
  }

  $(".goals-edit__form__fields--file__upload").on("change", ".goals-edit__form__file-field", function(e){
    $(".goals-edit__new-image-box").empty();
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);
    $(".goals-edit__new-image-box").append(buildImg(blobUrl));
  })

  $("#goals-edit__remove-preview-btn").click(function(){
    $(".goals-edit__new-image-box").empty();
    $(".goals-edit__form__file-field").remove();
    $(".goals-edit__form__upload-label").append(buildFileField);
  })

  $(".goals-edit__delete-current-image-btn").click(function(){
    if (!confirm("この操作は取り消せません")){
      return false;
    };
    $(".goals-edit__form__image__previews__current-image").addClass("grayout");
  })



  // collection_check_boxesの選択肢を表示するため
  $("#goals-edit__modal-fadein-btn").click(function(){
    var modalBtnText = $(this).text();
    if (modalBtnText == "カテゴリを選択") {
      $(".goals-edit__form__category__check-boxes__options-box").fadeIn();
      $(this).text("閉じる");
    } else {
      $(".goals-edit__form__category__check-boxes__options-box").fadeOut(50);
      $(this).text("カテゴリを選択");
    };
  });



  // カテゴリ作成フォーム表示のため
  $(document).on("click", "#create-category-btn", function(){
    let btnText = $("#create-category-btn").text()
    if (btnText == "カテゴリを作成") {
      $("ul").append(addedCategory)
      $("#create-category-btn").attr("class", "delete-btn").text("削除");
    } else {
      $(".added-categories").remove()
      $(this).attr("class", "create-category-btn").text("カテゴリを作成");
    };
  });



  // カテゴリ作成フォームのname属性切り替えのため
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