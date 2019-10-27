$(function(){

  function pushed_productsTab(data){
    $(".listing-tabs__tab").removeClass("active");
    data.addClass("active");

  }

  function display_to_message_at_nonproduct(text){

    $(".notpresent .gazou").empty();
    $(".notpresent .gazou").html(text);

  }

  if(document.URL.match(/.+\/users\/.+\/showedit/)){
    pushed_productsTab($(".tab_showedit"));
    display_to_message_at_nonproduct("出品中の商品はありません");
  }
  else if(document.URL.match(/.+\/users\/.+\/show_transaction/)){
    pushed_productsTab($(".tab_show_transaction"));
    display_to_message_at_nonproduct("取引中の商品はありません");
  }
  else if(document.URL.match(/.+\/users\/.+\/show_completed/)){
    pushed_productsTab($(".tab_show_completed"));
    display_to_message_at_nonproduct("売却済みの商品はありません");
  }
});