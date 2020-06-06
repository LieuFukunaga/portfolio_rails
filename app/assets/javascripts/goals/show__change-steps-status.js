$(function(){

  // goal, steps, actions共通 ページ遷移をキャンセル
  $(".goals-show__js-change-status").click(function(e){
    return false;
  })

  // href属性からレコードのstatusを抽出
  $(".goals-show__change-step-status-btn").click(function(){
    var href = $(this).attr("href");
    var status = href.split("=")[1];

    // statusを更新するレコード（goal, steps, actionsのいずれか）のidを取得
    var stepIndex = $(this).data("step-index");

    $.ajax({
      type: 'POST',
      url: href,
      data: { status: status},
      dataType: 'json'
    })
    .done(function(step){
      console.log(step);
      // from done to doing
      if (step.status == "doing") {
        var afterHref = href.replace("?status=done", "?status=doing");
        $(`#change-status__step-${stepIndex}`).attr("href", afterHref);
        $(`#step-status-icon_${stepIndex}`).removeClass("fas");
        $(`#step-status-icon_${stepIndex}`).removeClass("fa-check-circle");
        $(`#step-status-icon_${stepIndex}`).addClass("far");
        $(`#step-status-icon_${stepIndex}`).addClass("fa-circle");
      // from doing to done
      } else {
        var afterHref = href.replace("?status=doing", "?status=done");
        $(`#change-status__step-${stepIndex}`).attr("href", afterHref);
        $(`#step-status-icon_${stepIndex}`).removeClass("far");
        $(`#step-status-icon_${stepIndex}`).removeClass("fa-circle");
        $(`#step-status-icon_${stepIndex}`).addClass("fas");
        $(`#step-status-icon_${stepIndex}`).addClass("fa-check-circle");
      };
    })
    .fail(function() {
      alert("ステップの状態を更新できませんでした")
    })

  })
});