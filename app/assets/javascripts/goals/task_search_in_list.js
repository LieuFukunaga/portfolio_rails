$(function(){
  // タスク検索画面に表示されているタスクを削除する際のアラート表示のため
  $(".goals-task_search_in_list__delete-task-btn").on("click", function(){
    var taskId = $(this).data("trash-task-id");
    let taskTitle = $(`#searched_task_${taskId}`).text();
    if (!confirm(`”${taskTitle}” を削除してよろしいですか？`)){
      return false;
    } else {
      $(`tr[data-searched-task-id=${taskId}]`).fadeOut(200);
    };
  })
});