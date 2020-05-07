$(function(){
  $('#category-form').attr("name", 'no_category')

  $("#category-form").on("change", function (){
    let input = $("#category-form").val();
    if (input != "") {
      $('#category-form').attr("name", 'goal[categories_attributes][0][category_name]')
    } else {
      $('#category-form').attr("name", 'no_category')
    };
  });
});