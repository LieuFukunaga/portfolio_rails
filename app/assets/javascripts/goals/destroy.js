$(function(){
  // ＜次の７日間のタスク＞に表示されているタスクを削除する際のアラート表示のため
  $(".delete-task-btn").on("click", function(){
    var taskId = $(this).data("trash-task-id");
    let taskTitle = $(`#n7dt_title_${taskId}`).text();
    if (!confirm(`「${taskTitle}」を削除してよろしいですか？`)){
      return false;
    } else {
      $(`tr[data-search-result-id=${taskId}]`).fadeOut(200);
    };
  })

  // lists#showにおけるタスク削除のため
  $(".lists-show__delete-task-btn").click(function(){
    let goalId = $(this).data("task-id");
    let goalTitle = $(`#goal_${goalId}`).text();
    if (!confirm(`「 ${goalTitle} 」 を削除してよろしいですか？`)){
      return false;
    } else {
      $(`tr[data-lists-show-task-id=${goalId}]`).fadeOut(200);
    };
  });

});
