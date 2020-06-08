$(function(){
  // ========= for practices except practice-3 and practice-6 ==========

  function buildPracticesImg (blobUrl, practiceIndex){
    var html = `<img src="${blobUrl}" class="new-task-form__practice-previews practices-img_${practiceIndex}">`
    return html;
  }

  function buildPracticesFileField (practiceIndex){
    var fileField = `<input class="new-task-form__practices__file-field practices-file-field_${practiceIndex}" data-practice-index="${practiceIndex}" type="file" name="goal[practices_attributes][${practiceIndex}][practice_image]" id="goal_practices_attributes_${practiceIndex}_practice_image">`
    return fileField;
  }

  $(".new-task-form__practices__icons__upload").on("change", ".new-task-form__practices__file-field", function (e){
    var practiceIndex = $(this).data("practice-index");
    $(`.practice-previews_${practiceIndex}`).empty(); //ok
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $(`.practice-previews_${practiceIndex}`).append(buildPracticesImg(blobUrl, practiceIndex)); //ok
  })

  $(".new-task-form__practices__remove-preview-btn").click(function(){
    var practiceIndex = $(this).data("practice-index");
    $(`.practices-img_${practiceIndex}`).remove();
    $(`.practices-file-field_${practiceIndex}`).remove();
    $(`#practices-upload-label_${practiceIndex}`).append(buildPracticesFileField(practiceIndex));
  })



  // ========== only fot practice-3 and aciton-6 ==========

  function buildAnchorPracticeImg (blobUrl, practiceIndex){
    var html = `<img src="${blobUrl}" class="new-task-form__practice-previews practices-img_${practiceIndex}">`
    return html;
  }

  function buildAnchorPracticeFileField (practiceIndex){
    var fileField = `<input class="new-task-form__anchor-practices__file-field practices-file-field_${practiceIndex}" data-practice-index="${practiceIndex}" type="file" name="goal[practices_attributes][${practiceIndex}][practice_image]" id="goal_practices_attributes_${practiceIndex}_practice_image">`
    return fileField;
  }

  $(".new-task-form__anchor-practices__icons__upload").on("change", ".new-task-form__anchor-practices__file-field", function (e){
    var practiceIndex = $(this).data("practice-index");
    $(`.practice-previews_${practiceIndex}`).empty(); //ok
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $(`.practice-previews_${practiceIndex}`).append(buildAnchorPracticeImg(blobUrl, practiceIndex)); //ok
  })

  $(".new-task-form__anchor-practices__remove-preview-btn").click(function(){
    var practiceIndex = $(this).data("practice-index");
    $(`.practices-img_${practiceIndex}`).remove();
    $(`.practices-file-field_${practiceIndex}`).remove();
    $(`#practices-upload-label_${practiceIndex}`).append(buildAnchorPracticeFileField(practiceIndex));
  })
});