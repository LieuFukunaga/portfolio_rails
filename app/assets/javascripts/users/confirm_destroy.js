$(function(){
  $("#destroy-user-btn").click(function(){
    if (!confirm(`アカウントを削除すると作成したリストやタスク、カテゴリがすべて削除されます。\n\n※この操作は取り消せません。`)) {
      return false;
    }
  })
});