$(function(){
  // 画像アップロード時のプレビュー表示のため
  function buildImg (blobUrl){
    let html = `<img src="${blobUrl}" id="goals-new__image-preview" class="thumbnail--middle">`
    return html;
  }

  function appendFileField () {
    let fileField = `<input id="goals-new__file-field" type="file" name="goal[image]">`
    $(".goals-new__form__text-field__icons__upload__label").append(fileField);
  }

  $(".goals-new__form__text-field__icons__upload").on("change", "#goals-new__file-field", function(e){
    $(".goals-new__form__image__preview").empty();
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);
    $('.goals-new__form__image__preview').append(buildImg(blobUrl));
  })

  $("#goals-new__remove-preview-btn").click(function(){
    $(".goals-new__form__image__preview").empty();
    $("#goals-new__file-field").remove();
    appendFileField();
  })



  // collection_check_boxes表示切り替えのため
  $("#modal-fadein-btn").click(function(){
    $(".goals-new__form__category__check-boxes__options-box").fadeIn(100);
  });
  $("#modal-fadeout-btn").click(function(){
    $(".goals-new__form__category__check-boxes__options-box").fadeOut(100);
  });


  // text_fieldのname属性切り替えのため
  $(".hidden-field__user-id").attr("name", 'no_user');
  $('#create-category-form').attr("name", 'no_category');
  $("#create-category-form").on("change", function (){
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