$(function(){
  $(".categories-index__delete-btn").click(function(){
    let parent = $(this).parent();
    parent = parent.data('index');
    let categoryName = $(`#category-name_${parent}`).text();
    // if (!confirm(`${categoryName}を削除してよろしいですか？`)){
    //   return false;
    // };
  });
});