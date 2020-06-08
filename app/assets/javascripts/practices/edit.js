$(function(){
  // 画像アップロード時のプレビュー表示のため
  function buildImg (blobUrl){
    let html = `<div class="practices-edit__change-image-icon">
                  <i class="fas fa-angle-double-right"></i>
                </div>
                <div class="practices-edit__new-image">
                  <img src="${blobUrl}" class="practices-edit__new-image-preview">
                </div>`
    return html
  }

  function buildFileField () {
    let fileField = `<input class="practices-edit__file-field" type="file" name="practice[practice_image]">`
    return fileField
  }

  // プレビュー表示のため
  $(".practices-edit__icons").on("change", ".practices-edit__file-field", function(e){
    $(".practices-edit__new-image--flex").empty();
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);
    $(".practices-edit__new-image--flex").append(buildImg(blobUrl));
  })

  // プレビュー削除のため
  $("#practices-edit__remove-preview-btn").click(function(){
    $(".practices-edit__new-image--flex").empty();
    $(".practices-edit__file-field").remove();
    $(".practices-edit__upload-label").append(buildFileField);
  })

  // 現在の画像を削除するため
  $(".practices-edit__delete-current-image-btn").click(function(){
    if (!confirm("現在のイメージを削除してもよろしいですか？\n\n※この操作は取り消せません")){
      return false;
    };
    $(".practices-edit__current-image").addClass("grayout");
  })
});