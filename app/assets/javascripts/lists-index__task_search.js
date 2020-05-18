$(function() {
  // インクリメンタルサーチ用フォームのsubmitをキャンセルするため
  $('.lists-index__task-operator__search-form__form-field').on('submit', function(e){
    e.preventDefault()
  });

  let taskTable = $("#task-table")

  // 検索結果が１件以上の場合、テーブルの項目行を追加するため
  function appendTableHeader(){
    let tableHeader = `<thead id="task-table__header">
                        <tr>
                          <th>サムネイル</th>
                          <th>タスク名</th>
                          <th>所属リスト</th>
                          <th>予定日時</th>
                          <th>タスクの状態</th>
                        </tr>
                      </thead>
                      <tbody id="task-table__body" class="hover-records"></tbody>`
    taskTable.append(tableHeader).hide().fadeIn(300);
  }

  // table要素に検索結果を動的に追加するため
  function appendTask(task, index) {
    // 日付フォーマット用
    var date = new Date(task.date);
    var year = date.getFullYear();
    var month = ("00" + (date.getMonth()+1)).slice(-2);
    var day = ("00" + date.getDate()).slice(-2);
    var hour = date.getHours();
    var minute =date.getMinutes();

    if ( typeof task.image !== "undefined") {
      let html =`<tr>
                  <td>
                    <img src="${task.image}" width="100" height="100" class="task-search__images">
                  </td>
                  <td class="lists-task_search__results__task-${task.id}">
                    <a href="/lists/${task.list_id}/goals/${task.id}">
                      ${task.title}
                    </a>
                  </td>
                  <td>
                    <a href="/lists/${task.list_id}">
                      ${task.list_name}
                    </a>
                  </td>
                  <td>
                    ${year}/${month}/${day} ${hour}:${minute}
                  </td>
                  <td>
                    ${task.status}
                  </td>
                  <td>
                    <a href="/lists/${task.list_id}/goals/${task.id}/edit">
                      <i class="fas fa-edit"></i>
                    </a>
                  </td>
                  <td data-index="${task.id}">
                    <a class="lists-index__delete-task-btn" rel="nofollow" data-method="delete" href="/lists/${task.list_id}/goals/${task.id}/destroy_at_root">
                      <i class="fas fa-trash-alt"></i>
                    </a>
                  </td>
                </tr>`
      $("#task-table__body").append(html).hide().fadeIn(100);
    } else {
      let html =`<tr>
                  <td class="lists-index__task-search__no-image-icon">
                    <i class="fas fa-tasks no-image"></i>
                  </td>
                  <td class="lists-task_search__results__task-${task.id}">
                    <a href="/lists/${task.list_id}/goals/${task.id}">
                      "${task.title}"
                    </a>
                  </td>
                  <td>
                    <a href="/lists/${task.list_id}">
                      "${task.list_name}"
                    </a>
                  </td>
                  <td>
                  ${year}/${month}/${day} ${hour}:${minute}
                  </td>
                  <td>
                    "${task.status}"
                  </td>
                  <td>
                  <a href="/lists/${task.list_id}/goals/${task.id}/edit">
                    <i class="fas fa-edit"></i>
                  </a>
                  </td>
                  <td data-index="${task.id}">
                    <a class="lists-index__delete-task-btn" rel="nofollow" data-method="delete" href="/lists/${task.list_id}/goals/${task.id}/destroy_at_root">
                      <i class="fas fa-trash-alt"></i>
                    </a>
                  </td>
                </tr>`
      $("#task-table__body").append(html).hide().fadeIn(100);
    };
  }

  // 検索結果が0件の場合のメッセージ表示のため
  function appendNoMatchMessage(message) {
    let noMatchMessage = `<thead class='nothing'>
                            <tr>
                              <th>${message}</th>
                            </tr>
                          </thead>`
    taskTable.append(noMatchMessage).hide().fadeIn(300);
  }

  // タスクを削除するかの確認のため
  $("#task-table").on("click", ".lists-index__delete-task-btn", function(){
    let parent = $(".lists-index__delete-task-btn").parent();
    console.log(parent);
    let taskId = parent.data('index');
    let goalTitle = $(`.lists-task_search__results__task-${taskId}`).text();
    console.log(`${goalTitle}`);
    if (!confirm(`${goalTitle}を削除してよろしいですか？`)){
      return false;
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
        results.forEach(function(task, index){
          appendTask(task, index)
        });
      } else {
        $("#task-table").empty();
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