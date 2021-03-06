$(function(){

  $("td.js-change-status").on("click", function(e){
    // e.preventDefault();
    return false;
  })

  $(".change-status-link").on("click", function(){
    // href属性からgoalのstatusカラムのデータを抽出
    let href = $(this).attr("href");
    let status = href.split("=")[1];

    // 直属のtd要素のカスタムデータ属性からタスクのidを取得
    let taskId = $(this).parents(".js-change-status").data("id");

    $.ajax({
      type: 'POST',
      url: href,
      data: { status: status},
      dataType: 'json'
    })
    // 引数task＝”状態が更新されたタスク”
    .done(function(task){
      // 更新後の状態が「実行中」の場合
      if (task.status == "doing") {
        var beforeHref = $(`#change_status_task_${taskId}`).attr("href");
        afterHref = beforeHref.replace("?status=done", "?status=doing");
        $(`#change_status_task_${taskId}`).text("実行中").attr("href", afterHref);
        $(`#change_status_task_${taskId}`).removeClass("lists-index__goal--done");
        $(`#change_status_task_${taskId}`).addClass("lists-index__goal--doing");
        // 更新後の状態が「達成！」の場合
      } else {
        var beforeHref = $(`#change_status_task_${taskId}`).attr("href");
        afterHref = beforeHref.replace("?status=doing", "?status=done");
        $(`#change_status_task_${taskId}`).text("達成！").attr("href", afterHref);
        $(`#change_status_task_${taskId}`).removeClass("lists-index__goal--doing");
        $(`#change_status_task_${taskId}`).addClass("lists-index__goal--done");
      };
    })
    .fail(function(){
      alert("タスクの状態を更新できませんでした")
    })
  })
});