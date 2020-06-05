$(function(){
  // 画像アップロード時のプレビュー表示のため
  function buildImg (blobUrl){
    let html = `<div class="steps-edit__change-image-icon">
                  <i class="fas fa-angle-double-right"></i>
                </div>
                <div class="steps-edit__new-image">
                  <img src="${blobUrl}" class="steps-edit__new-image-preview">
                </div>`
    return html
  }

  function buildFileField () {
    let fileField = `<input class="steps-edit__file-field" type="file" name="step[step_image]">`
    return fileField
  }

  $(".steps-edit__icons__upload-image").on("change", ".steps-edit__file-field", function(e){
    $(".new-image--flex").empty();
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);
    $(".new-image--flex").append(buildImg(blobUrl));
  })

  $("#steps-edit__remove-preview-btn").click(function(){
    $(".new-image--flex").empty();
    $(".steps-edit__file-field").remove();
    $(".steps-edit__upload-label").append(buildFileField);
  })

  $(".steps-edit__delete-current-image-btn").click(function(){
    if (!confirm("この操作は取り消せません")){
      return false;
    };
    $(".current-image").addClass("grayout");
  })
});