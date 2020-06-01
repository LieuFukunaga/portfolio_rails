$(function(){
  // ========= for actions except action-3 and action-6 ==========

  function buildActionsImg (blobUrl, actionIndex){
    var html = `<img src="${blobUrl}" class="new-task-form__action-previews actions-img_${actionIndex}">`
    return html;
  }

  function buildActionsFileField (actionIndex){
    var fileField = `<input class="new-task-form__actions__file-field actions-file-field_${actionIndex}" data-action-index="${actionIndex}" type="file" name="goal[actions_attributes][${actionIndex}][action_image]" id="goal_actions_attributes_${actionIndex}_action_image">`
    return fileField;
  }

  $(".new-task-form__actions__icons__upload").on("change", ".new-task-form__actions__file-field", function (e){
    var actionIndex = $(this).data("action-index");
    $(`.action-previews_${actionIndex}`).empty();
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $(`.action-previews_${actionIndex}`).append(buildActionsImg(blobUrl, actionIndex));
  })

  $(".new-task-form__actions__remove-preview-btn").click(function(){
    var actionIndex = $(this).data("action-index");
    $(`.actions-img_${actionIndex}`).remove();
    $(`.actions-file-field_${actionIndex}`).remove();
    $(`.actions-upload-label_${actionIndex}`).append(buildActionsFileField(actionIndex));
  })



  // ========== only fot action-3 and aciton-6 ==========

  function buildAnchorActionImg (blobUrl, actionIndex){
    var html = `<img src="${blobUrl}" class="new-task-form__action-previews actions-img_${actionIndex}">`
    return html;
  }

  function buildAnchorActionFileField (actionIndex){
    var fileField = `<input class="new-task-form__anchor-actions__file-field actions-file-field_${actionIndex}" data-action-index="${actionIndex}" type="file" name="goal[actions_attributes][${actionIndex}][action_image]" id="goal_actions_attributes_${actionIndex}_action_image">`
    return fileField;
  }

  $(".new-task-form__anchor-actions__icons__upload").on("change", ".new-task-form__anchor-actions__file-field", function (e){
    var actionIndex = $(this).data("action-index");
    $(`.action-previews_${actionIndex}`).empty();
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    $(`.action-previews_${actionIndex}`).append(buildAnchorActionImg(blobUrl, actionIndex));
  })

  $(".new-task-form__anchor-actions__remove-preview-btn").click(function(){
    var actionIndex = $(this).data("action-index");
    $(`.actions-img_${actionIndex}`).remove();
    $(`.actions-file-field_${actionIndex}`).remove();
    $(`.actions-upload-label_${actionIndex}`).append(buildAnchorActionFileField(actionIndex));
  })
});