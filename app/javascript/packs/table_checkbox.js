//  view/user_itemsで使用

var select_flag = 0;
var item_ids_array = [];

    ///CSRFトークンを取得・セット
    function set_csrftoken() {
      $.ajaxPrefilter(function (options, originalOptions, jqXHR) {
          if (!options.crossDomain) {
              const token = $('meta[name="csrf-token"]').attr('content');
              if (token) {
                  return jqXHR.setRequestHeader('X-CSRF-Token', token);
              }
          }
      });
    };

    // ajax通信条件にCSRFトークンを入れる
    set_csrftoken();

$(document).on("click", '.doropdown-list-delete', function(){
  $('.item-delete-button').show();
  $('.item-cancel-button').show();
  //ボタンを無効化しておく
  select_flag = 1;
  item_ids_array = [];
  console.log(item_ids_array);
  //削除ボタンの無効化
  $('.item-delete-button').prop("disabled", true);
  //カーソルをポインターへ変更
  $(".checkbox_row").css("cursor","pointer")
});

    $(document).on("click", '.checkbox_row', function(){
        //tr要素をクリックでイベント発火
        var checkbox_icon = $(this).find('.fa-check-circle');
        //クリックした行のアイテムidを取得
        var item_ids = $(this).attr('id');
        //クリックしたアイテムidを検索
        var serch_array = $.inArray(item_ids, item_ids_array)
        console.log(serch_array)
        //arrayに含まれない場合-1が返る
        if (serch_array === -1 && select_flag === 1) {
          item_ids_array.push(item_ids);
          checkbox_icon.show();
        } else {
          item_ids_array.splice(serch_array,1);
          checkbox_icon.hide();
        }
        console.log(item_ids_array)

        //削除ボタンの有効/無効の切り替え
        if (item_ids_array.length === 0) {
            $('.item-delete-button').prop("disabled", true);
        } else {
            $('.item-delete-button').prop("disabled", false);
        }
    });

    //ajaxで削除実行
    $(document).on("click",'.item-delete-button', function(){
      console.log('削除クリック')
      if(!confirm('アイテムを削除しますか？')){
        /* キャンセルの時の処理 */
        return false;
    }else{
        /*　OKの時の処理 */
        $.ajax({
          url: '/user_items/' + 1,
          type: 'POST',
          data: {'item_ids': item_ids_array,
                 '_method': 'DELETE'} // DELETE リクエストだよ！と教えてあげる。
        });
        $('.item-delete-button').hide();
        $('.item-cancel-button').hide();
        item_ids_array = [];
        select_flag = 0;
    };
    });

    //cancelボタンのクリック
    $(document).on("click", '.item-cancel-button', function(){
      $('.item-delete-button').hide();
      $('.item-cancel-button').hide();
      var checkbox_icon = $('.fa-check-circle');
      checkbox_icon.hide();
      item_ids_array = [];
      select_flag = 0;
      $(".checkbox_row").css("cursor","default")
    });
