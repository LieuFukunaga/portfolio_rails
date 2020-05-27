$(function(){
  // プルダウンメニューが変更されたらイベント発火
  $('select[name=sort_order]').change(function(){
    let currentOption = $(this).val();
    // console.log(currentOption);
    // 選択肢に応じたURLパラメータを変数化
    if (currentOption == "title_asc") {
      var html = "&sort=title+asc"
    } else if (currentOption == "title_desc") {
      var html = "&sort=title+desc"
    } else if (currentOption == "date_asc") {
      var html = "&sort=date+asc"
    } else if (currentOption == "date_desc") {
      var html = "&sort=date+desc"
    } else if (currentOption == "status_asc") {
      var html = "&sort=status+asc"
    } else if (currentOption == "status_desc") {
      var html = "&sort=status+desc"
    } else if (currentOption == "updated_at_asc") {
      var html = "&sort=updated_at+asc"
    } else if (currentOption == "updated_at_desc") {
      var html = "&sort=updated_at+desc"
    } else {
      var html = ""
    };

    console.log(html);

    // 現在のページのURLを取得
    var currentHref = window.location.href;
    // console.log(currentHref);

    // ソート機能の重複防止
    if(location.href.match(/&sort=.+/) != null) {
      var currentHref = currentHref.replace(location.href.match(/&sort=.+/)[0], '') // matchメソッドの返り値は配列。検索にマッチした文字列は添字0に格納されている。
    };

    // ページ遷移
    window.location.href = currentHref + html
    // console.log(window.location.href);
  });

  // ページ遷移後の挙動
  $(function(){
    if (location.href.match(/&sort=.+/) != null) {
      // （念のため）選択解除
      if ($("select option:selected")) {
        $("select option:first").prop("selected", false);
      }
      let selectedOption = location.href.match(/&sort=.+/)[0].replace('&sort=', '')

      if(selectedOption == "title+asc") {
        var sort = 1
      } else if (selectedOption == "title+desc") {
        var sort = 2
      } else if (selectedOption == "date+asc") {
        var sort = 3
      } else if (selectedOption == "date+desc") {
        var sort = 4
      } else if (selectedOption == "status+asc") {
        var sort = 5
      } else if (selectedOption == "status+desc") {
        var sort = 6
      } else if (selectedOption == "updated_at+asc") {
        var sort = 7
      } else if (selectedOption == "updated_at+desc") {
        var sort = 8
      }

      let add_selected = $('select[name=sort_order]').children()[sort]
      $(add_selected).attr('selected', true)
    }
  });
});