$(function() {

  let taskTable = $("#task-table")

  function appendTableHeader(){
    let tableHeader = `<thead id="task-table__header">
                        <tr>
                          <th>サムネイル</th>
                          <th>タスク名</th>
                          <th>予定日時</th>
                          <th>タスクの状態</th>
                        </tr>
                      </thead>
                      <tbody id="task-table__body"></tbody>`
    taskTable.append(tableHeader).hide().fadeIn(300);
  }

  function appendNoMatchMessage(message) {
    let noMatchMessage = `<thead class='nothing'>
                            <tr>
                              <th>${message}</th>
                            </tr>
                          </thead>`
    taskTable.append(noMatchMessage).hide().fadeIn(300);
  }

  function appendTask(task, index) {
    if ( typeof task.image !== "undefined") {
      let html =`<tr>
                  <td>
                    <img src="${task.image}" width="100" height="100">
                  </td>
                  <td class="lists-task_search__results__task-${index + 1}">
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
                    "${task.status}"
                  </td>
                </tr>`
      $("#task-table__body").append(html).hide().fadeIn(100);
    } else {
      let html =`<tr>
                  <td>
                    <i class="fas fa-tasks lists-show__no-image"></i>
                  </td>
                  <td class="lists-task_search__results__task-${index + 1}">
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
                    "${task.status}"
                  </td>
                </tr>`
      $("#task-table__body").append(html).hide().fadeIn(100);
    };
  }

  $("#task-search-form").on("keyup", function() {
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