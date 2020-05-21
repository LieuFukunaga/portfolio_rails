$(function(){
  $(".lists-show__delete-btn").click(function(){
    let parentId = $(this).parent().data("id");
    let goalTitle = $(`#goal_${parentId}`).text();
    if (!confirm(`「 ${goalTitle} 」 を削除してよろしいですか？`)){
      return false;
    };
  });
});