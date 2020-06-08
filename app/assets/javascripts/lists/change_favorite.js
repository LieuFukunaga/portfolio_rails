$(function(){
  $("td.js-change-favorite").on("click", function(e){
    // e.preventDefault();
    return false;
  })

  $(".change-favorite-icons").click(function(){
    // href属性からlistのfavoriteカラムのデータを抽出
    var href = $(this).attr("href");
    // console.log(href);
    var favorite = href.split("=")[1];
    // console.log(favorite);

    var listId = $(this).data("list-id");
    // console.log(listId);

    $.ajax({
      type: 'POST',
      url: href,
      data: { favorite: favorite },
      dataType: 'json'
    })
    .done(function(list){
      // console.log(list);
      if (list.favorite == "ordinary") {
        var afterHref = href.replace("?favorite=favorite", "?favorite=ordinary");
        $(`#change-favorite__list_${listId}`).attr("href", afterHref);
        $(`#list_${listId}__favorite-icon`).removeClass("fas");
        $(`#list_${listId}__favorite-icon`).addClass("far");
      } else {
        var afterHref = href.replace("?favorite=ordinary", "?favorite=favorite");
        $(`#change-favorite__list_${listId}`).attr("href", afterHref);
        $(`#list_${listId}__favorite-icon`).removeClass("far");
        $(`#list_${listId}__favorite-icon`).addClass("fas");
      };
    })
    .fail(function() {
      alert("お気に入りを更新できませんでした")
    })
  })
});