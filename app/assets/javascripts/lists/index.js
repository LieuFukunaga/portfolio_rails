$(function(){
  // リスト削除の確認アラート表示のため
  $(".lists-index__delete-btn").click(function(){
    let listId = $(this).data('trash-list-id');
    let listName = $(`#list_${listId}`).text();
    if (!confirm(`「${listName}」を削除してよろしいですか？\n\n※リストを削除するとリスト内のタスクも削除されます。この操作は取り消せません。`)){
      return false;
    } else {
        $(`tr[data-list-id=${listId}]`).fadeOut(200);
    };
  });

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
});