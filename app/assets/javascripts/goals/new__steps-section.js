$(function(){
  // ========= セクション: Steps ==========

  function buildStepImg (blobUrl, stepIndex){
    var html = `<img src="${blobUrl}" class="new-task-form__step-previews step-img_${stepIndex}">`
    return html;
  }

  function buildStepFileField (stepIndex){
    var fileField = `<input class="new-task-form__steps__file-field step-file-field_${stepIndex}" data-step-index="${stepIndex}" type="file" name="goal[image]">`
    return fileField;
  }

  $(".new-task-form__steps__fields__image__icons__upload").on("change", ".new-task-form__steps__file-field", function (e){
    var stepIndex = $(this).data("step-index");
    $(`.step-preview_${stepIndex}`).empty();
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $(`.step-preview_${stepIndex}`).append(buildStepImg(blobUrl, stepIndex));
  })

  $(".new-task-form__steps__remove-preview-btn").click(function(){
    var stepIndex = $(this).data("step-index");
    $(`.step-img_${stepIndex}`).remove();
    $(`.step-file-field_${stepIndex}`).remove();
    $(`.step-upload-label_${stepIndex}`).append(buildStepFileField(stepIndex));
  })
});