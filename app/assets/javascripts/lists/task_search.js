$(function() {
  // インクリメンタルサーチ用フォームのsubmitをキャンセルするため
  $('.lists-index__task-operator__search-form__form-field').on('submit', function(e){
    e.preventDefault()
  });

  let taskTable = $("#searched-task-table")

  // 検索結果が１件以上の場合、テーブルの項目行を追加するため
  function appendTableHeader(){
    let tableHeader = `<thead id="task-table__header">
                        <tr>
                          <th>サムネイル</th>
                          <th>タイトル</th>
                          <th>所属リスト</th>
                          <th>予定日時</th>
                          <th>状態</th>
                        </tr>
                      </thead>
                      <tbody id="task-table__body" class="hover-records"></tbody>`
    taskTable.append(tableHeader).hide().fadeIn(200);
  }

  // table要素に検索結果を動的に追加するため
  function appendTask(task) {
    // 日付フォーマット用
    var date = new Date(task.date);
    var year = date.getFullYear();
    var month = ("00" + (date.getMonth()+1)).slice(-2);
    var day = ("00" + date.getDate()).slice(-2);
    var hour = ("00" + date.getHours()).slice(-2);
    var minute =("00" + date.getMinutes()).slice(-2);
    var weekday = date.getDay();
    var youbi= [ "日", "月", "火", "水", "木", "金", "土" ][weekday];// 曜日(日本語表記)

    if ( typeof task.image !== "undefined") {
      if (task.status == "doing"){
        // 画像あり・実行中
        var html =`<tr data-search-result-id="${task.id}">
                    <td class="thumbnail td-image">
                      <img src="${task.image}" class="lists-index__task_search__images thumbnail--small">
                    </td>
                    <td>
                      <a id="task_search__result-${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        ${task.title}
                      </a>
                    </td>
                    <td>
                      <a href="/lists/${task.list_id}">
                        ${task.list_name}
                      </a>
                    </td>
                    <td>
                      ${year}/${month}/${day} ${hour}:${minute} (${youbi})
                    </td>
                    <td class="js-change-status" data-id="${task.id}">
                      <a class="change-status-links lists-index__goal--doing" id="task_${task.id}_${task.status}" rel="nofollow" data-method="post" href="javascript:void(0)" data-href="/lists/${task.list_id}/goals/${task.id}/change_status_at_root">実行中</a>
                    </td>
                    <td>
                      <a class="appended-delete-task-btn" rel="nofollow" data-method="delete" data-trash-task-id="${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        <i class="fas fa-trash"></i>
                      </a>
                    </td>
                  </tr>`
        $("#task-table__body").append(html).hide().fadeIn(200);
      } else {
        // 画像あり・達成！
        var html =`<tr data-search-result-id="${task.id}">
                    <td class="thumbnail td-image">
                      <img src="${task.image}" class="lists-index__task_search__images thumbnail--small">
                    </td>
                    <td>
                      <a id="task_search__result-${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        ${task.title}
                      </a>
                    </td>
                    <td>
                      <a href="/lists/${task.list_id}">
                        ${task.list_name}
                      </a>
                    </td>
                    <td>
                      ${year}/${month}/${day} ${hour}:${minute} (${youbi})
                    </td>
                    <td class="js-change-status" data-id="${task.id}">
                      <a class="change-status-links lists-index__goal--done" id="task_${task.id}_${task.status}" rel="nofollow" data-method="post" href="javascript:void(0)" data-href="/lists/${task.list_id}/goals/${task.id}/change_status_at_root">達成！</a>
                    </td>
                    <td>
                      <a class="appended-delete-task-btn" rel="nofollow" data-method="delete" data-trash-task-id="${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        <i class="fas fa-trash"></i>
                      </a>
                    </td>
                  </tr>`
        $("#task-table__body").append(html).hide().fadeIn(200);
      };
    } else {
      if (task.status == "doing"){
        // 画像なし・実行中
        var html =`<tr data-search-result-id="${task.id}">
                    <td class="lists-index__task-search__no-image-icon">
                      <i class="fas fa-tasks no-image"></i>
                    </td>
                    <td>
                      <a id="task_search__result-${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        ${task.title}
                      </a>
                    </td>
                    <td>
                      <a href="/lists/${task.list_id}">
                        ${task.list_name}
                      </a>
                    </td>
                    <td>
                      ${year}/${month}/${day} ${hour}:${minute} (${youbi})
                    </td>
                    <td class="js-change-status" data-id="${task.id}">
                      <a class="change-status-links  lists-index__goal--doing" id="task_${task.id}_${task.status}" rel="nofollow" data-method="post" href="javascript:void(0)" data-href="/lists/${task.list_id}/goals/${task.id}/change_status_at_root">実行中</a>
                    </td>
                    <td>
                      <a class="appended-delete-task-btn" rel="nofollow" data-method="delete" data-trash-task-id="${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        <i class="fas fa-trash"></i>
                      </a>
                    </td>
                  </tr>`
        $("#task-table__body").append(html).hide().fadeIn(200);
      } else {
        // 画像なし・達成
        var html =`<tr data-search-result-id="${task.id}">
                    <td class="lists-index__task-search__no-image-icon">
                      <i class="fas fa-tasks no-image"></i>
                    </td>
                    <td>
                      <a id="task_search__result-${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        ${task.title}
                      </a>
                    </td>
                    <td>
                      <a href="/lists/${task.list_id}">
                        ${task.list_name}
                      </a>
                    </td>
                    <td>
                      ${year}/${month}/${day} ${hour}:${minute} (${youbi})
                    </td>
                    <td class="js-change-status" data-id="${task.id}">
                      <a class="change-status-links lists-index__goal--done" id="task_${task.id}_${task.status}" rel="nofollow" data-method="post" href="javascript:void(0)" data-href="/lists/${task.list_id}/goals/${task.id}/change_status_at_root">達成！</a>
                    </td>
                    <td>
                      <a class="appended-delete-task-btn" rel="nofollow" data-method="delete" data-trash-task-id="${task.id}" href="/lists/${task.list_id}/goals/${task.id}">
                        <i class="fas fa-trash"></i>
                      </a>
                    </td>
                  </tr>`
        $("#task-table__body").append(html).hide().fadeIn(200);
      };

    };
  }

  function appendNoMatchMessage(message) {
    var html = `<h3 class='name'>${ message }</h3>`
    taskTable.append(html);
  }

  // 動的に追加されたタスクを削除する際のアラート表示のため
  $("#searched-task-table").on("click", ".appended-delete-task-btn", function(){
    let taskId = $(this).data("trash-task-id");
    let goalTitle = $(`#task_search__result-${taskId}`).text();
    goalTitle = goalTitle.replace(`\n`, "");
    if (!confirm(`${goalTitle}を削除してよろしいですか？`)){
      return false;
    } else {
      $(`tr[data-search-result-id=${taskId}]`).fadeOut(200);
    };
  })





  $("#task-searcher").on("keyup", function() {
    taskTable.empty();
    let input = $(this).val();
    $.ajax({
      type: 'GET',
      url: 'lists/task_search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(results){ // data: リクエストによって返ってきたレスポンス。jbuilderで作成されたJSONデータ
      taskTable.empty();
      if (results.length !== 0) {
        appendTableHeader()
        results.forEach(function(task){
          appendTask(task)
        });
      } else {
        $("#searched-task-table").empty();
        appendNoMatchMessage("一致するタスクがありません")
      }
    })
    .fail(function() {
      alert("検索エラー")
    })
  });

  $("#task-search-form").on("change", function(){
    if ($(this).val() == "") {
      $("#task-table").empty();
    };
  });

});