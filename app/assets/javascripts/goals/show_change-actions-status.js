$(function(){

  // goal, steps, actions共通 ページ遷移をキャンセル
  $(".goals-show__js-change-status").click(function(e){
    return false;
  })

  // href属性からレコードのstatusを抽出
  $(".goals-show__change-action-status-btn").click(function(){
    var href = $(this).attr("href");
    var status = href.split("=")[1];

    // statusを更新するレコード（goal, steps, actionsのいずれか）のidを取得
    var actionIndex = $(this).data("action-index");

    $.ajax({
      type: 'POST',
      url: href,
      data: { status: status},
      dataType: 'json'
    })
    .done(function(action){
      // from done to doing
      if (action.status == "doing") {
        var afterHref = href.replace("?status=done", "?status=doing");
        $(`#change-status__action-${actionIndex}`).attr("href", afterHref);
        $(`#action-status-icon_${actionIndex}`).removeClass("fas");
        $(`#action-status-icon_${actionIndex}`).removeClass("fa-check-circle");
        $(`#action-status-icon_${actionIndex}`).addClass("far");
        $(`#action-status-icon_${actionIndex}`).addClass("fa-circle");
      // from doing to done
      } else {
        var afterHref = href.replace("?status=doing", "?status=done");
        $(`#change-status__action-${actionIndex}`).attr("href", afterHref);
        $(`#action-status-icon_${actionIndex}`).removeClass("far");
        $(`#action-status-icon_${actionIndex}`).removeClass("fa-circle");
        $(`#action-status-icon_${actionIndex}`).addClass("fas");
        $(`#action-status-icon_${actionIndex}`).addClass("fa-check-circle");
      };
    })
    .fail(function() {
      alert("アクションの状態を更新できませんでした")
    })

  })
});