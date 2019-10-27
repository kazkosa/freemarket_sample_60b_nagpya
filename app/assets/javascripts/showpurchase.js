$(function(){

  function pushed_productsTab(data){
    $(".listing-tabs__tab").removeClass("active");
    data.addClass("active");

  }

  function display_to_message_at_nonproduct(text){

    $(".notpresent .gazou").empty();
    $(".notpresent .gazou").html(text);

  }

  if(document.URL.match(/.+\/users\/.+\/purchased/)){
    pushed_productsTab($(".tab_purchased_completed"));
    display_to_message_at_nonproduct("過去に取引した商品がありません");
  }
  else if(document.URL.match(/.+\/users\/.+\/purchase/)){
    pushed_productsTab($(".tab_purchase_transaction"));
    display_to_message_at_nonproduct("取引中の商品はありません");
  }
});