$(function(){
  $(document).on("click", ".categories-index__delete-btn", function(){
    let parent = $(this).parent();
    parent = parent.data('index');
    let categoryName = $(`#category-name_${parent}`).text();
    if (!confirm(`${categoryName}を削除してよろしいですか？`)){
      return false;
    };
  });
});