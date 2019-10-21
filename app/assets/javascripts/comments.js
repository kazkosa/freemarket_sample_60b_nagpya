$(function(){
  function buildHTML(data){
    var html_seller = data.seller? `<div class="item-box-message__container__content__list__message-box__lunchar__role">出品者</div>` : ``;
    var html = `
      <li class="item-box-message__container__content__list__message-box">
        <a class="item-box-message__container__content__list__message-box__lunchar" href="/users/2">
          <figure class="item-box-message__container__content__list__message-box__lunchar__box">
            <div class="item-box-message__container__content__list__message-box__lunchar__box__avatar">
              <img src="//static.mercdn.net/thumb/members/810915501.jpg?1395785151">
            </div>
            <div class="item-box-message__container__content__list__message-box__lunchar__box__name">
              yamada
            </div>
          </figure>
          ${html_seller}
        </a>
        <div class="item-box-message__container__content__list__message-box__body">
          <div class="item-box-message__container__content__list__message-box__body__text">
            ${data.body}
          </div>
          <div class="item-box-message__container__content__list__message-box__body__wrapper">
            <time class="item-box-message__container__content__list__message-box__body__wrapper__icon-left">
              <i class="far fa-clock icon-time fa-lg"></i>
              <span>
                ${data.created_at}
              </span>
            </time>
            <div class="item-box-message__container__content__list__message-box__body__wrapper__icon-right">
              <form action="" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="NNiDIng6WiVNQl1xKq+/pnnmV4TcBhFrx9nEoyP5MUW4XOkvjwFWn96Q7915fy3+QZ6R1hHYBrClDcai8Wp8BA==">
                <div class="actions">
                  <button name="button" type="submit" class="btn-flag">
                    <i class="far fa-flag icon-flag fa-lg"></i>
                  </button>
                </div>
              </form>
            </div>
            <div class="item-box-message__container__content__list__message-box__body__balloon">
            </div>
        </div>
      </div>
    </li> 
    `;
    $(".item-box-message__container__content__list").append(html);
  }

  //  Comment send by ajax
  $(".item-box-message__container__notice__form").on("submit", function(e){
    e.preventDefault();
    var input = $(".textarea-default").val().replace(/\r|\n|\r\n/g, '<br>');
    var formData = new FormData(this);
    var url = $(this).attr("action");

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(data){
      //'if branch' is set to reject the case which the submit btn pressed unless user have nothing enter the comment
      if(data){
        //build html
        buildHTML(data);

        //auto scroll
        var target = $(".item-box-message__container__content__list__message-box").last();
        var position = target.offset().top + $(".item-box-message__container__content__list").scrollTop();
        $(".item-box-message__container__content__list").animate({scrollTop: position}, 300, 'swing');
      
      }
      else{
        alert("Reject by Irregular comment"); 
      }
      //form reset
      $(".item-box-message__container__notice__form")[0].reset();
      $(".item-box-message__container__notice__form__submit").removeAttr("disabled");
    })
    .fail(function(){
      alert("Error");
    })
  });
});
