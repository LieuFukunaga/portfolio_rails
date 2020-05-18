$(function(){

  if ($(".lists-show__change-status-btn").val() == "doing") {
    $(".lists-show__change-status-btn").css('background-color', 'red');
  } else {
    $(".lists-show__change-status-btn").css('background-color', 'blue');
  };

  $(".lists-show__change-status-btn").change(function(){
    if ($(this).val() == "doing") {
      $(this).css('background-color', 'red');
    } else {
      $(this).css('background-color', 'blue');
    };
  })
});