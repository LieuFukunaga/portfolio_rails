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

  // リセット確認：practices
  $(".goals-show__reset-practices-btn").click(function(){
    var practiceId = $(this).data("practice-id");
    var practiceTitle = $(`#practice-id_${practiceId}`).text();
    if (!confirm(`「${practiceTitle}」をリセットしてよろしいですか？\n\n※この操作は取り消せません`)){
      return false;
    };
  })
});