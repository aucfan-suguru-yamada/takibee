$(function(){
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#camp_camp_image').change(function(){
    //登録ボタンを有効
    $('.item-submit-button').prop("disabled", false);
    //選択したfileのオブジェクトをpropで取得
    var files = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();

      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files

      //var num = $('.item-image').length + 1 + i
      fileReader.readAsDataURL(file);

      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `
                      <div class='item-image col-md-4' data-image="${file.name}">
                        <div class=' item-image__content'>
                          <div class='item-image__content--icon'>
                            <img src=${src} style="max-width:100%; max-height:500px;" >
                          </div>
                        </div>
                        <br>
                        <div class='item-image__operetion'>
                          <div class='item-image__operetion--delete'>
                          <i class="far fa-times-circle text-danger fa-lg"></i>
                        </div>
                        </div>
                      </div>
                      <br>
                      `
        //image_box__container要素の前にhtmlを差し込む
        $('#modal_image_box').after(html);
      };
    });

    //モーダル使えないかなあ
    var modal = document.getElementById( 'modal01' );
    $( modal ).fadeIn( 300 );
    return false;
  });

  // モーダルウィンドウを閉じる
  $( '.js-modal-close' ).on( 'click', function() {
    $( '.js-modal' ).fadeOut( 300 );
    $('input[type=file]').val(null)
    dataBox.clearData();
    var target_image = $('.item-image');
    target_image.remove();
    return false;
  });

  //削除ボタンをクリックすると発火するイベント
  $(document).on("click", '.item-image__operetion--delete', function(){
  //削除を押されたプレビュー要素を取得
  var target_image = $(this).parent().parent()
  //削除を押されたプレビューimageのfile名を取得
  var target_name = $(target_image).data('image')
  //プレビューがひとつだけの場合、file_fieldをクリア
  if(file_field.files.length==1){
    //inputタグに入ったファイルを削除
    $('input[type=file]').val(null)
    dataBox.clearData();
  }else{
    //プレビューが複数の場合
    $.each(file_field.files, function(i,input){
      //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
      if(input.name==target_name){
        dataBox.items.remove(i);
      }
    })
    //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
    file_field.files = dataBox.files
  }
  //プレビューを削除
  target_image.remove();
  if(file_field.files.length==0){
  $('.item-submit-button').prop("disabled", true);
  };
});
});