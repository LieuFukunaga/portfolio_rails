$(function(){
  // トップページ、リスト削除の確認アラート表示のため
  $(".lists-index__delete-btn").click(function(){
    let listId = $(this).data('trash-list-id');
    let listName = $(`#list_${listId}`).text();
    if (!confirm(`「${listName}」を削除してよろしいですか？`)){
      return false;
    } else {
        $(`tr[data-list-id=${listId}]`).fadeOut(200);
    };
  });
});