$(function(){
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