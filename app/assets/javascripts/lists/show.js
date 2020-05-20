$(function(){
  $(".lists-show__delete-btn").click(function(){
    let parent = $(this).parent();
    parent = parent.data('index');
    let goalTitle = $(`#goal_${parent}`).text();
    if (!confirm(`${goalTitle}を削除してよろしいですか？`)){
      return false;
    };
  });
});