$(function(){

  // リセット確認：goal
  $(".goals-show__reset-goal-btn").click(function(){
    var goalId = $(this).data("goal-id");
    var goalTitle = $(`#goal-id_${goalId}`).text();
    if (!confirm(`「${goalTitle}」をリセットしてよろしいですか？\n\n※この操作は取り消せません`)){
      return false;
    };
  })

  // リセット確認：steps
  $(".goals-show__reset-step-btn").click(function(){
    var stepId = $(this).data("step-id");
    var stepTitle = $(`#step-id_${stepId}`).text();
    if (!confirm(`「${stepTitle}」をリセットしてよろしいですか？\n\n※この操作は取り消せません`)){
      return false;
    };
  })

  // リセット確認：actions
  $(".goals-show__reset-actions-btn").click(function(){
    var actionId = $(this).data("action-id");
    var actionTitle = $(`#action-id_${actionId}`).text();
    if (!confirm(`「${actionTitle}」をリセットしてよろしいですか？\n\n※この操作は取り消せません`)){
      return false;
    };
  })
});