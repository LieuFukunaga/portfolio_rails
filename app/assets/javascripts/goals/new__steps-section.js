$(function(){
  // ========= for step_1, step_2 ==========

  function buildStepsImg (blobUrl, stepIndex){
    var html = `<img src="${blobUrl}" class="new-task-form__step-previews steps-img_${stepIndex}">`
    return html;
  }

  function buildStepsFileField (stepIndex){
    var fileField = `<input class="new-task-form__steps__file-field steps-file-field_${stepIndex}" data-step-index="${stepIndex}" type="file" name="goal[steps_attributes][${stepIndex}][step_image]" id="goal_steps_attributes_${stepIndex}_step_image">`
    return fileField;
  }

  $(".new-task-form__steps__fields__image__icons__upload").on("change", ".new-task-form__steps__file-field", function (e){
    var stepIndex = $(this).data("step-index");
    // console.log(stepIndex);
    $(`.step-previews_${stepIndex}`).empty();
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $(`.step-previews_${stepIndex}`).append(buildStepsImg(blobUrl, stepIndex));
  })

  $(".new-task-form__steps__remove-preview-btn").click(function(){
    var stepIndex = $(this).data("step-index");
    $(`.steps-img_${stepIndex}`).remove();
    $(`.steps-file-field_${stepIndex}`).remove();
    $(`#steps-upload-label_${stepIndex}`).append(buildStepsFileField(stepIndex));
  })



  // ========== for step_3 ==========

  function buildAnchorStepImg (blobUrl, stepIndex){
    var html = `<img src="${blobUrl}" class="new-task-form__step-previews steps-img_${stepIndex}">`
    return html;
  }

  function buildAnchorStepFileField (stepIndex){
    var fileField = `<input class="new-task-form__anchor-step__file-field steps-file-field_${stepIndex}" data-step-index="${stepIndex}" type="file" name="goal[steps_attributes][${stepIndex}][step_image]" id="goal_steps_attributes_${stepIndex}_step_image">`
    return fileField;
  }

  $(".new-task-form__anchor-step__fields__image__icons__upload").on("change", ".new-task-form__anchor-step__file-field", function (e){
    var stepIndex = $(this).data("step-index");
    console.log(stepIndex);
    $(`.step-previews_${stepIndex}`).empty();
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $(`.step-previews_${stepIndex}`).append(buildAnchorStepImg(blobUrl, stepIndex));
  })

  $(".new-task-form__anchor-step__remove-preview-btn").click(function(){
    var stepIndex = $(this).data("step-index");
    $(`.steps-img_${stepIndex}`).remove();
    $(`.steps-file-field_${stepIndex}`).remove();
    $(`#steps-upload-label_${stepIndex}`).append(buildAnchorStepFileField(stepIndex));
  })
});