$(function(){

  $("form.button_to").on("submit", function(e){
    e.preventDefault();
  });

  $(".change-status-btn").on("click", function(){
    // "実行中"または"達成！"を取得
    let status = $(this).val();
    // 直属のtd要素のカスタムデータ属性からタスクのidを取得
    let taskId = $(this).parents(".js-change-status").data("id");
    // 直属のform要素のaction属性を取得
    let url = $(this).parents("form.button_to").attr("action");
    $.ajax({
      type: 'POST',
      url: url,
      data: { status: status},
      dataType: 'json'
    })
    .done(function(task){
      if (task.status == "doing") {
        $(`.goal_${taskId}`).val("実行中");
        $(`.goal_${taskId}`).removeClass("goal--done");
        $(`.goal_${taskId}`).addClass("goal--doing");
      } else {
        $(`.goal_${taskId}`).val("達成！");
        $(`.goal_${taskId}`).removeClass("goal--doing");
        $(`.goal_${taskId}`).addClass("goal--done");
      };
    })
    .fail(function(){
      alert("タスクの状態を更新できませんでした")
    })
  })
});