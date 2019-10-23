$(function(){

  $(".to-confirmation-of-buy-action").on("click",function(e){
    e.preventDefault();
    $(".overlay").fadeIn(200);
    $(".modal_exhibit-comp").fadeIn(200);
  })

  $(".process-cancel-bock").on("click",function(e){
    e.preventDefault();
    $(".overlay").fadeOut(200);
    $(".modal_exhibit-comp").fadeOut(200);
  })
});
