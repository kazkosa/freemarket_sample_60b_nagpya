$(function(){
  $("#modal-open-btn").on("click",function(e){
    e.preventDefault();
    $("#overlay").fadeIn();
  })
});
$(function(){
  $("#modal-close-btn").on("click",function(e){
    e.preventDefault();
    $('#overlay').fadeOut();
  })
});
