$(function(){
  $("#modal-open-btn").on("click",function(e){
    e.preventDefault();
    $("#overlay").fadeIn();
    console.log("good night");
  })
});
$(function(){
  $("#modal-close-btn").on("click",function(e){
    e.preventDefault();
    $('#overlay').fadeOut();
    console.log("hello");
  })
});
