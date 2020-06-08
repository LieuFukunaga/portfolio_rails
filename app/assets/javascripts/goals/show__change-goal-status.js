$(function(){

  // goal, steps, actions共通 ページ遷移をキャンセル
  $(".goals-show__js-change-status").click(function(e){
    return false;
  })

  // href属性からレコードのstatusを抽出
  $(".goals-show__change-status-btn").click(function(){
    var href = $(this).attr("href");
    var status = href.split("=")[1];

    $.ajax({
      type: 'POST',
      url: href,
      data: { status: status},
      dataType: 'json'
    })
    .done(function(goal){
      // from done to doing
      if (goal.status == "doing") {
        var afterHref = href.replace("?status=done", "?status=doing");
        $("#change-status__goal").attr("href", afterHref);
        $(".goals-show__change-status-icons").removeClass("fas");
        $(".goals-show__change-status-icons").removeClass("fa-check-circle");
        $(".goals-show__change-status-icons").addClass("far");
        $(".goals-show__change-status-icons").addClass("fa-circle");
      // from doing to done
      } else {
        var afterHref = href.replace("?status=doing", "?status=done");
        $("#change-status__goal").attr("href", afterHref);
        $(".goals-show__change-status-icons").removeClass("far");
        $(".goals-show__change-status-icons").removeClass("fa-circle");
        $(".goals-show__change-status-icons").addClass("fas");
        $(".goals-show__change-status-icons").addClass("fa-check-circle");
      };
    })
    .fail(function() {
      alert("タスクの状態を更新できませんでした")
    })

  })
});