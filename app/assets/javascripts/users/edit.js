$(function(){

  function buildAvatar(blobUrl) {
    let html = `<img src="${blobUrl}" class="users-edit__new-avatar-preview">`
    return html
  };

  $(".users-edit__operator__upload").on("change", "#users-edit__file-field", function(e){
    $(".users-edit__avatar").empty();
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);
    $(".users-edit__avatar").append(buildAvatar(blobUrl));
  })

  $("#remove-avatar-btn").click(function(){
    if (!confirm("この操作は取り消せません")){
      return false;
    } else {
      $("#current-avatar").addClass("grayout");
    };
  })

});