$(function(){
  function buildImage(loadedImageUri){
    var html =
    `<li>
      <div class="img-box">
        <img src=${loadedImageUri}>
      </div>
      <div class="item__images__container__preview__box">
        <div class="delete_btn_box delete_img_js">
          <div class="item__images__container__preview__box__delete">削除</a>
        </div>
      </div>
    </li>`
    return html
  };

  function valid_Result_Disp(data){
    var error_null    =`<span style="color:red;" class="error-message"> 入力してください </span>`;
    var error_sellect =`<span style="color:red;" class="error-message"> 選択してください </span>`;
    var error_forbit  =`<span style="color:red;" class="error-message"> 300以上9999999以下で入力してください </span>`;
    
    $(".error-message").remove();
    if (data.product_id){
      $(".overlay").fadeIn(200);
      $(".modal_exhibit-comp").fadeIn(200);
      var path="/products/" + data.product_id;
      $(".link_to_product").attr("href",path);
    }
    else{
      alert('入力違反!! 再度入力内容を確認してください。');
      if(data.product_image_errors_image){
        $(".block-image").append(error_null);
      }
      if(data.product_errors_title){
        $(".block-title").append(error_null);
      }
      if(data.product_errors_description){
        $(".block-description").append(error_null);
      }
      if(data.product_errors_category_id){
        $(".block-category").append(error_sellect);
      }
      if(data.product_errors_size){
        $(".block-size").append(error_sellect);
      }
      if(data.product_errors_condition){
        $(".block-condition").append(error_sellect);
      }
      if(data.product_errors_shipping_charges){
        $(".block-shipping_charges").append(error_sellect);
      }
      if(data.product_errors_shipping_method){
        $(".block-shipping_method").append(error_sellect);
      }
      if(data.product_errors_shipping_area){
        $(".block-shipping_area").append(error_sellect);
      }
      if(data.product_errors_shipping_date){
        $(".block-shipping_date").append(error_sellect);
      }
      if(data.product_errors_price){
        $(".block-price").append(error_forbit);
      }
      $(".btn-submit").removeAttr("disabled");
    }
  }

  var files_array = []
  var total_image_max = 10;
  //ドラッグドロップによる画像取得
  $('.item__images__container__guide').on('dragover',function(e){
      e.preventDefault();
  });
  $('.item__images__container__guide').on('drop',function(event){
    event.preventDefault();
    files = event.originalEvent.dataTransfer.files;

    if( files_array.length + files.length + alreadysavedtotal - delete_request_index.length <= total_image_max){
      for (var i=0; i<files.length; i++) {
        files_array.push(files[i]);
        var fileReader = new FileReader();
        fileReader.onload = function( event ) {
          var loadedImageUri = event.target.result;      
          $(buildImage(loadedImageUri,)).appendTo(".item__images__container__wrapper:last-child .item__images__container__preview ul");
        };
        fileReader.readAsDataURL(files[i]);
      }
    }
    else{
      alert("登録可能な最大数を超えているためアップロードできません。");
    }
  });
  
  // クリック時のイベントの作成
  $('.upload-image').on('change',function(event){
    event.preventDefault();
    files = $(this)[0].files;
    if( files_array.length + files.length + alreadysavedtotal - delete_request_index.length <= total_image_max){
      for (var i=0; i<files.length; i++) {
        files_array.push(files[i]);
        var fileReader = new FileReader();
        fileReader.onload = function( event ) {
          var loadedImageUri = event.target.result;
          $(buildImage(loadedImageUri,)).appendTo(".item__images__container__wrapper:last-child .item__images__container__preview ul").trigger("create").trigger("create");
        };
        fileReader.readAsDataURL(files[i]);
      }
    }
    else{
      alert("登録可能な最大数を超えているためアップロードできません。");
    }
  });

  // クリックされたaタグの順番から、削除すべき画像を特定し、配列から削除する。
  $(document).on('click','.delete_img_js', function(){
    var index = $(".delete_img_js").index(this);
    files_array.splice(index - 1, 1);
    $(this).parent().parent().remove();
  });

  //出品処理
  $('#new_item').on('submit', function(e){
    e.preventDefault();
    // そのほかのform情報を以下の記述でformDataに追加
    var formData = new FormData($(this).get(0));
    // ドラッグアンドドロップで、取得したファイルをformDataに入れる。
    files_array.forEach(function(file){
    formData.append("image[images][]" , file)
    });
    $.ajax({
      url:         '/products',
      type:        "POST",
      data:        formData,
      contentType: false,
      processData: false,
      dataType:   'json',
    })
    .done(function(data){
      valid_Result_Disp(data);
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert('出品に失敗しました！');
      $(".btn-submit").removeAttr("disabled");
    });
  });


  //出品時の画像数を取得
  var alreadysavedtotal = 0;
  if ( $(".block-image").data("alreadysavedtotal") ){
    alreadysavedtotal = $(".block-image").data("alreadysavedtotal");
  }
  
  var delete_request_index = [];
  $(document).on("click",".delete_btn_box2", function(){
    var index = $(".delete_btn_box2").index(this);
    // クリックされたaタグの順番から、削除すべき画像を特定し、配列から削除する。
    // files_array.splice(index - 1, 1);
    delete_request_index.push($(this).parent().parent().data("alreadysaved"));
    $(this).parent().parent().remove();
  });

  //編集処理
  $('#edit_item').on('submit', function(e){
    e.preventDefault();
    var productid = $(".item__form__sellcontent__submit__done").data("productid")
    var url = "/products/"+productid;      
    // そのほかのform情報を以下の記述でformDataに追加
    var formData = new FormData($(this).get(0));
    // ドラッグアンドドロップで、取得したファイルをformDataに入れる。
    files_array.forEach(function(file){
    formData.append("image[images][]" , file)
    });
    delete_request_index.forEach(function(data){
      formData.append("product[delete_request_index][]" , data)
    });
    $.ajax({
      url:         url,
      type:        "PATCH",
      data:        formData,
      contentType: false,
      processData: false,
      dataType:   'json',
    })
    .done(function(data){
      valid_Result_Disp(data);
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert('出品に失敗しました！');
      $(".btn-submit").removeAttr("disabled");
    });
  });



  //手数料計算
  var money_l = 300;
  var money_h =9999999;
  var fee_rate = 0.1;
  if($(".money_box").val()){
    var input_money = $(".money_box").val();
    if(input_money >= money_l && input_money <= money_h){
      var fee     = Math.floor(input_money*fee_rate);
      var profit  = input_money - fee;
      $(".l-right.fee").html("¥"+fee.toString().replace(/(\d)(?=(\d{3})+$)/g , '$1,'));
      $(".l-right.profit").html("¥"+profit.toString().replace(/(\d)(?=(\d{3})+$)/g , '$1,')); 
    }
    else{
      $(".l-right.fee").html("");
      $(".l-right.profit").html(""); 
    }
  }
  $(".money_box").on("keyup", function(){
    var input_money = $(".money_box").val();
    if(input_money >= money_l && input_money <= money_h){
      var fee     = Math.floor(input_money*fee_rate);
      var profit  = input_money - fee;
      $(".l-right.fee").html("¥"+fee.toString().replace(/(\d)(?=(\d{3})+$)/g , '$1,'));
      $(".l-right.profit").html("¥"+profit.toString().replace(/(\d)(?=(\d{3})+$)/g , '$1,')); 
    }
    else{
      $(".l-right.fee").html("");
      $(".l-right.profit").html(""); 
    }
  });


  //カテゴリー選択
  $("#parent-form").on("change",function(){
    var input = $(this).val();
    var url = "/products/select_category_m";    
    if(input !== "" ){
      $.ajax({
        url: url,
        type: 'get',
        data:{category_id1: input},
        dataType:'json'
      })
      .done(function(data){
        if (data.length !== 0) {
          $(".children-form").show();
          $("#children-form").empty();
          $("#grandchildren-form").empty();

          var op1 = document.createElement("option");
          op1.value = 0;  //value値
          op1.text = "---";  //テキスト値
          $("#children-form").append(op1);

          var op2 = document.createElement("option");
          op2.value = 0;  //value値
          op2.text = "---";  //テキスト値
          $("#grandchildren-form").append(op2);

          for( var i=0; i < data.length ; i++ ){             
            var op = document.createElement("option");
            op.value = data[i].id;  //value値
            op.text = data[i].name;  //テキスト値
            $("#children-form").append(op);

          }
        }
      })
      .fail(function(){
        alert("Search error");
      })
    }
  });
  $("#children-form").on("change",function(){
    var input = $(this).val();
    var url = "/products/select_category_s";    
    if(input !== "" ){
      $.ajax({
        url: url,
        type: 'get',
        data:{category_id2: input},
        dataType:'json'
      })
      .done(function(data){
        if (data.length !== 0) {
          $(".grandchildren-form").show();
          $("#grandchildren-form").empty();
          var op0 = document.createElement("option");
          op0.value = 0;  //value値
          op0.text = "---";  //テキスト値
          $("#grandchildren-form").append(op0)
          for( var i=0; i < data.length ; i++ ){              
            var op = document.createElement("option");
            op.value = data[i].id;  //value値
            op.text = data[i].name;  //テキスト値
            $("#grandchildren-form").append(op)
          }
        }
      })
      .fail(function(){
        alert("Search error");
      })
    }
  });
  // カテゴリ編集時は初期表示
  if(document.URL.match(/.+\/products\/.+\/edit/)){
    $(".children-form").show();
    $(".grandchildren-form").show();
  }

});
