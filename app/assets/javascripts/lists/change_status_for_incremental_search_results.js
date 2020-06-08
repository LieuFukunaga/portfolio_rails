$(function(){

  $("#searched-task-table").on("click", ".change-status-links", function(){

    var href = $(this).data("href");
    // console.log(`① data属性から抽出：${href}`);
    var idStatus = $(this).attr("id");
    // console.log(`② id属性：${idStatus}`);
    var taskId = idStatus.split("_")[1]
    // console.log(`③ id属性からタスクidを抽出：${taskId}`);
    var beforeStatus = idStatus.split("_")[2]
    // console.log(`④ id属性からstatusを抽出${beforeStatus}`);

    $.ajax({
      type: 'POST',
      url: href,
      data: { status: beforeStatus},
      dataType: 'json'
    })
    // 引数task＝”状態が更新されたタスク”
    .done(function(task){
      // console.log(`⑤ 更新後のタスクの状態：${task.status}`);
      $(`#task_${task.id}_${beforeStatus}`).attr("id", `task_${task.id}_${task.status}`);

      if (task.status == "doing") {
        $(`#task_${task.id}_${task.status}`).text("実行中");
        $(`#task_${task.id}_${task.status}`).removeClass("lists-index__goal--done");
        $(`#task_${task.id}_${task.status}`).addClass("lists-index__goal--doing");
      } else {
        $(`#task_${task.id}_${task.status}`).text("達成！");
        $(`#task_${task.id}_${task.status}`).removeClass("lists-index__goal--doing");
        $(`#task_${task.id}_${task.status}`).addClass("lists-index__goal--done");
      };
    })
    .fail(function(){
      alert("タスクの状態を更新できませんでした")
    })
  })
});