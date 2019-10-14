
$(function(){ 
 $(".item-box-container__main__photo__inner__smal-box-wrapper__item").hover(function(e){
  e.preventDefault();

  var w = $(window).width();
  var disp_th = 768;
  var unit_img_pc = 300;
  var unit_img_iphone = 288;
  
  var unit_img_latest = ( w > disp_th? unit_img_pc:unit_img_iphone);
  
  $(".item-box-container__main__photo__inner__smal-box-wrapper__item").removeClass("active");
  var current_hover_id = $(this).addClass("active");
  if ( current_hover_id.is("#image1")){
   $(".item-box-container__main__photo__inner__large-box__wrapper").css("left",unit_img_latest*0); 

  }else if( current_hover_id.is("#image2")  ){
   $(".item-box-container__main__photo__inner__large-box__wrapper").css("left",-unit_img_latest*1);
  }else if( current_hover_id.is("#image3")  ){
   $(".item-box-container__main__photo__inner__large-box__wrapper").css("left",-unit_img_latest*2);
  }else if( current_hover_id.is("#image4")  ){
   $(".item-box-container__main__photo__inner__large-box__wrapper").css("left",-unit_img_latest*3);
  }else if( current_hover_id.is("#image5")  ){
   $(".item-box-container__main__photo__inner__large-box__wrapper").css("left",-unit_img_latest*4);
  }else{
   alert.log("Error: Selected irregular image!");
  }
 
 })
});