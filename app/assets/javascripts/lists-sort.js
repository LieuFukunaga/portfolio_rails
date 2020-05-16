$(function(){
  // プルダウンメニューが変更されたらイベント発火
  $("select[name=sort_order]").change(function(){
    let currentOption = $(this).val();

    if (currentOption == "list_name_asc") {
      html = "&sort=list_name+asc"
    } else if (currentOption == "list_name_desc") {
      html = "&sort=list_name+desc"
    } else if (currentOption == "updated_at_asc") {
      html = "&sort=updated_at+asc"
    } else if (currentOption == "updated_at_desc") {
      html = "&sort=updated_at+desc"
    } else {
      html = ""
    };

    // 現在のページのURLを取得
    let currentPage = window.location.href;

    // ソート機能の重複防止
    if(location['href'].match(/sort=*.+/) != null) {
      let remove = location['href'].match(/&sort=*.+/)[0]
      let currentPage = currentPage.replace(remove, '')
    };
    // ページ遷移
    window.location.href = currentPage + html
  });

  // ページ遷移後の挙動
  $(function(){
    if (location['href'].match(/&sort=*.+/) != null) {
      // option[selected: 'selected']を削除
      if ($('select option[selected=selected]')) {
        $('select option:first').prop('selected', false);
      }
      let selectedOption = location['href'].match(/&sort=*.+/)[0].replace('&sort=', '')

      if(selectedOption == "list_name+asc") {
        let sort = 1
      } else if (selectedOption == "list_name+desc") {
        let sort = 2
      } else if (selectedOption == "updated_at+asc") {
        let sort = 3
      } else if (selectedOption == "updated_at+desc") {
        let sort = 4
      }

      let add_selected = $('select[name=sort_order]').children()[sort]
      $(add_selected).attr('selected', true)
    }
  });
});