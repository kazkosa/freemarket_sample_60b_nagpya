$(function(){
  if($(".like_btn").data("like")){
    $(".off-to-on").hide();
    $(".on-to-off").show();
    $(".item-box-container__evaluation-btn__left__like").css("border","1px solid lightcoral");

  }else{
    $(".on-to-off").hide();
    $(".off-to-on").show();
    $(".item-box-container__evaluation-btn__left__like").css("border","none");

  }
});