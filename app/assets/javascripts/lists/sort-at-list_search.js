$(function(){
  // プルダウンメニューが変更されたらイベント発火
  $('select[name=sort]').change(function(){
    let currentOptionVal = $(this).val();

    if (currentOptionVal == "list_name_asc") {
      // 選択肢に応じたURLパラメータを変数htmlに代入
      var html = "&sort=list_name+asc"
    } else if (currentOptionVal == "list_name_desc") {
      var html = "&sort=list_name+desc"
    } else if (currentOptionVal == "updated_at_asc") {
      var html = "&sort=updated_at+asc"
    } else if (currentOptionVal == "updated_at_desc") {
      var html = "&sort=updated_at+desc"
    } else {
      var html = ""
    };

    // 現在のページのURLを取得
    var currentHref = window.location.href;

    // ソート機能の重複防止
    if(location.href.match(/&sort=.+/) != null) {
      // &sort以降だけを削除
      var currentHref = currentHref.replace(location.href.match(/&sort=.+/)[0], '') // matchメソッドの返り値は配列。検索にマッチした文字列は添字0に格納されている。
    };

    // ページ遷移
    window.location.href = currentHref + html
  });

  // ページ遷移後の挙動
  $(function(){
    if (location.href.match(/&sort=.+/) != null) {
      // （念のため）選択解除
      if ($("select option:selected")) {
        $("select option:selected").prop("selected", false);
      }
      let selectedOption = location.href.match(/&sort=.+/)[0].replace('&sort=', '')

      if(selectedOption == "list_name+asc") {
        var sort = 1
      } else if (selectedOption == "list_name+desc") {
        var sort = 2
      } else if (selectedOption == "updated_at+asc") {
        var sort = 3
      } else if (selectedOption == "updated_at+desc") {
        var sort = 4
      }

      let add_selected = $('select[name=sort]').children()[sort]
      $(add_selected).attr('selected', true)
      $("option[value=location.pathname]").text(add_selected.text());
    }
  });
});