$(function(){
  $(".lists-index__delete-btn").click(function(){
    let parent = $(this).parent();
    parent = parent.data('index');
    let listName = $(`#list_${parent}`).text();
    if (!confirm(`${listName}を削除してよろしいですか？`)){
      return false;
    };
  });
});