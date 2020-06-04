$(function(){
  // ========== セクション: Goal ==========

  // 画像アップロード時のプレビュー表示のため
  function buildImg (blobUrl){
    var html = `<img src="${blobUrl}" class="new-task-form__goal__image__preview">`
    return html;
  }

  var fileField = `<input class="new-task-form__goal__file-field" type="file" name="goal[image]">`


  $(".new-task-form__goal__fields__image").on("change", ".new-task-form__goal__file-field", function(e){
    $(".new-task-form__goal__image__preview").empty();
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $('.new-task-form__goal__image__preview').append(buildImg(blobUrl));
  })

  $(".new-task__goal__remove-preview-btn").click(function(){
    $(".new-task-form__goal__image__preview").empty();
    $(".new-task-form__goal__file-field").remove();
    $(".new-task-form__goal__upload-label").append(fileField);
  })



  // collection_check_boxes表示切り替えのため
  $("#goals-new__modal-fadein-btn").click(function(){
    var modalBtnText = $(this).text();
    if (modalBtnText == "カテゴリを選択") {
      $(".new-task-form__category__check-boxes__options-box").fadeIn();
      $(this).text("閉じる")
    } else {
      $(".new-task-form__category__check-boxes__options-box").fadeOut(50);
      $(this).text("カテゴリを選択");
    };
  });


  // text_fieldのname属性切り替えのため
  $(".hidden-field__category__user-id").attr("name", 'no_user');
  $('#create-category-form').attr("name", 'no_category');
  $("#create-category-form").on("change", function (){
    var input = $(this).val();
    if (input != "") {
      $(this).attr("name", 'goal[categories_attributes][0][category_name]')
      $(".hidden-field__category__user-id").attr("name", 'goal[categories_attributes][0][user_id]')
    } else {
      $(this).attr("name", 'no_category')
      $(".hidden-field__category__user-id").attr("name", 'no_user')
    };
  });

});