$(function(){
  // トップページ、リスト削除の確認アラート表示のため
  $(".lists-index__delete-btn").click(function(){
    let parent = $(this).parent();
    let listIndex = parent.data('list-index');
    let listName = $(`#list_${listIndex}`).text();
    if (!confirm(`${listName}を削除してよろしいですか？`)){
      return false;
    };
  });

  // ＜次の７日間のタスク＞に表示されているタスクを削除する際のアラート表示のため
  $(".delete-n7dt-btn").on("click", function(){
    let parent = $(this).parent();
    let recordIndex = parent.data('n7dt-trash');
    console.log(`${recordIndex}`);
    let goalTitle = $(`#n7dt_title_${recordIndex}`).text();
    if (!confirm(`${goalTitle}を削除してよろしいですか？`)){
      return false;
    };
  })
});