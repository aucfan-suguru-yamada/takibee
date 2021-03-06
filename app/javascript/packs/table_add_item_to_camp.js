//  view/camp_items/my_itemsで使用
var item_ids_array = [];
var camp_id = $('.camp_id').attr('id');
$('.add-item-button').prop("disabled", true);
$(".checkbox_row").css("cursor","pointer");

    $(document).on("click", '.checkbox_row', function(){
        //tr要素をクリックでイベント発火
        var checkbox_icon = $(this).find('.fa-check-circle');
        var added_status = $(this).find('.added_status').text();
        console.log(added_status)
        //クリックした行のアイテムidを取得
        var item_ids = $(this).attr('id');
        //クリックしたアイテムidを検索
        var serch_array = $.inArray(item_ids, item_ids_array)
        console.log(serch_array)
        //arrayに含まれない場合-1が返る
        if (serch_array === -1 && added_status === '未登録') {
          item_ids_array.push(item_ids);
          checkbox_icon.show();
        }
        if (serch_array > -1 && added_status === '未登録') {
          item_ids_array.splice(serch_array,1);
          checkbox_icon.hide();
        }
        console.log(item_ids_array)

        //削除ボタンの有効/無効の切り替え
        if (item_ids_array.length === 0) {
            $('.add-item-button').prop("disabled", true);
        } else {
            $('.add-item-button').prop("disabled", false);
        }
    });

    //cancelボタンのクリック
    $(document).on("click", '.item-cancel-button', function(){
      $('.item-delete-button').hide();
      $('.item-cancel-button').hide();
      var checkbox_icon = $('.fa-check-circle');
      checkbox_icon.hide();
      item_ids_array = [];
      $(".checkbox_row").css("cursor","default")
    });


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

    //ajaxでpost実行
    $(document).on("click",'.add-item-button', function(){
      console.log('追加クリック')
      if(!confirm('アイテムを追加しますか？')){
        /* キャンセルの時の処理 */
        return false;
      }else{
        /*　OKの時の処理 */
        $.ajax({
          url: '/camps/' + camp_id + '/add_my_items',
          type: 'POST',
          data: {'item_ids': item_ids_array
                }
        }).done(function(){
          console.log('ページ遷移')
          location.href = './';
        });
        item_ids_array = [];
      };
    });