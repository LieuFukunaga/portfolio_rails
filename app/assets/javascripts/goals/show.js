$(function(){

  $(".goals-show__task-info--middle__change-status").on("click", function(e){
    // e.preventDefault();
    return false;
  })

  $(".goals-show__task-info--middle__change-status__link").on("click", function(){
    // レコードのリンク先情報に持たせておいた"status"を抽出
    let href = $(this).attr("href");
    let status = href.split("=")[1];
    // console.log(`${status}`);

    // 直属のtd要素のカスタムデータ属性からタスクのidを取得
    let taskId = $(this).parent().data("id");

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

        // 更新後の状態が「達成！」の場合
      } else {
        var beforeHref = $(`#change_status_task_${taskId}`).attr("href");
        afterHref = beforeHref.replace("?status=doing", "?status=done");
        $(`#change_status_task_${taskId}`).text("達成！").attr("href", afterHref);
      };
    })
    .fail(function(){
      alert("タスクの状態を更新できませんでした")
    })
  })
});