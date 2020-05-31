$(function(){
  // ========== セクション: Goal ==========

  // 画像アップロード時のプレビュー表示のため
  function buildImg (blobUrl){
    let html = `<img src="${blobUrl}" class="new-task-form__goal__image__preview">`
    return html;
  }

  let fileField = `<input class="new-task-form__goal__file-field" type="file" name="goal[image]">`


  $(".new-task-form__goal__fields__image").on("change", ".new-task-form__goal__file-field", function(e){
    $(".new-task-form__goal__image__preview").empty();
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);
    $('.new-task-form__goal__image__preview').append(buildImg(blobUrl));
  })

  $(".new-task__goal__remove-preview-btn").click(function(){
    $(".new-task-form__goal__image__preview").empty();
    $(".new-task-form__goal__file-field").remove();
    $(".new-task-form__goal__upload-label").append(fileField);
  })



  // collection_check_boxes表示切り替えのため
  $("#modal-fadein-btn").click(function(){
    $(".new-task-form__category__check-boxes__options-box").fadeIn(100);
  });
  $("#modal-fadeout-btn").click(function(){
    $(".new-task-form__category__check-boxes__options-box").fadeOut(100);
  });


  // text_fieldのname属性切り替えのため
  $(".hidden-field__category__user-id").attr("name", 'no_user');
  $('#create-category-form').attr("name", 'no_category');
  $("#create-category-form").on("change", function (){
    let input = $(this).val();
    if (input != "") {
      $(this).attr("name", 'goal[categories_attributes][0][category_name]')
      $(".hidden-field__category__user-id").attr("name", 'goal[categories_attributes][0][user_id]')
    } else {
      $(this).attr("name", 'no_category')
      $(".hidden-field__category__user-id").attr("name", 'no_user')
    };
  });
  // ========= セクション: Step ==========

  // ========= セクション: Action ==========

});