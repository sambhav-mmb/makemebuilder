$(document).ready(function(){

  $("form input[type=submit]").attr("data-disable-with", "Loading...");

  $(document).click(function() {
    $('.flash_msg').remove()
  })

  $("a.open-quote-popup-category").click(function(){
    var category = $(this).attr("data-category");
    $("select#category").val(category);
  })

  $('.datepicker').datepicker({
    format: 'dd/M/yyyy',
    autoclose: true
  });
	
});

setTimeout(function(){
  $(".flash_msg").remove();
}, 5000);