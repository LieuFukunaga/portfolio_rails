$(function(){

  // goal, steps, practices共通 ページ遷移をキャンセル
  $(".goals-show__js-change-status").click(function(e){
    return false;
  })

  // href属性からレコードのstatusを抽出
  $(".goals-show__change-practice-status-btn").click(function(){
    var href = $(this).attr("href");
    var status = href.split("=")[1];

    // statusを更新するレコード（goal, steps, practicesのいずれか）のidを取得
    var practiceIndex = $(this).data("practice-index");

    $.ajax({
      type: 'POST',
      url: href,
      data: { status: status},
      dataType: 'json'
    })
    .done(function(practice){
      // from done to doing
      if (practice.status == "doing") {
        var afterHref = href.replace("?status=done", "?status=doing");
        $(`#change-status__practice-${practiceIndex}`).attr("href", afterHref);
        $(`#practice-status-icon_${practiceIndex}`).removeClass("fas");
        $(`#practice-status-icon_${practiceIndex}`).removeClass("fa-check-circle");
        $(`#practice-status-icon_${practiceIndex}`).addClass("far");
        $(`#practice-status-icon_${practiceIndex}`).addClass("fa-circle");
      // from doing to done
      } else {
        var afterHref = href.replace("?status=doing", "?status=done");
        $(`#change-status__practice-${practiceIndex}`).attr("href", afterHref);
        $(`#practice-status-icon_${practiceIndex}`).removeClass("far");
        $(`#practice-status-icon_${practiceIndex}`).removeClass("fa-circle");
        $(`#practice-status-icon_${practiceIndex}`).addClass("fas");
        $(`#practice-status-icon_${practiceIndex}`).addClass("fa-check-circle");
      };
    })
    .fail(function() {
      alert("アクションの状態を更新できませんでした")
    })

  })
});
