$(function(){
  // プレビューに挿入するHTMLの作成
  function buildImage(loadedImageUri){
    var html =
    `<li>
      <img src=${loadedImageUri}>
      <div class="item__images__container__preview__box">
        <div class="item__images__container__preview__box__edit" >
          編集
        </div>
        <div>
          <a class="item__images__container__preview__box__delete">削除</a>
        </div>
      </div>
    </li>`
    return html
  };
  // 画像を管理するための配列を定義する。
  var files_array = [];
  // 通常のドラッグオーバイベントを止める。
  $('.item__images__container__guide').on('dragover',function(e){
      e.preventDefault();
  });
  // ドロップ時のイベントの作成
  $('.item__images__container__guide').on('drop',function(event){
    event.preventDefault();
      // 何故か、dataTransferがうまくいかなかったので、originalEventから読み込んでいます。
      // ここで、イベントによって得たファイルを配列で取り込んでいます。
    files = event.originalEvent.dataTransfer.files;
      // 画像のファイルを一つづつ、先ほどの画像管理用の配列に追加する。
    for (var i=0; i<files.length; i++) {
      files_array.push(files[i]);
      var fileReader = new FileReader();
      // ファイルが読み込まれた際に、行う動作を定義する。
      // FileReader オブジェクトを使うと、ユーザーのコンピューター内にあるファイル (もしくはバッファ上の生データ) をウェブアプリケーションから非同期的に読み込むことが出来ます。
      fileReader.onload = function( event ) {
      // 画像のurlを取得します。
      var loadedImageUri = event.target.result;
      // console.log("event.target.result(=loadedImageUri):" + event.target.result);
      
      // 取得したURLを利用して、ビューにHTMLを挿入する。
      $(buildImage(loadedImageUri,)).appendTo(".item__images__container__preview ul");//.trigger("create");
      };
      // ファイルの読み込みを行う。
      fileReader.readAsDataURL(files[i]);
    }
  });
    // div配下のaタグがクリックされた際に、イベントを発生させる。
  $(document).on('click','.item__images__container__preview a', function(){
    // index関数を利用して、クリックされたaタグが、div内で何番目のものか特定する。
    var index = $(".item__images__container__preview a").index(this);
    // クリックされたaタグの順番から、削除すべき画像を特定し、配列から削除する。
    files_array.splice(index - 1, 1);
    // クリックされたaタグが含まれるli要素をHTMLから削除する。
    $(this).parent().parent().parent().remove();
   
  });


  // submitボタンが押された際のイベント
  $('#new_item').on('submit', function(e){
    e.preventDefault();
    // そのほかのform情報を以下の記述でformDataに追加
    var formData = new FormData($(this).get(0));
    // console.log(file);
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
      alert('出品に成功しました！');
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert('出品に失敗しました！');
    });
  });
});

