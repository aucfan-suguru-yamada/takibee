//  view/every_camp/indexで使用
$(document).on("click", '.js-modal-img', function(){
  //var src = $(this).children().children().attr('src');
  //var src = $(this).children().children().attr('src');
  var img_id = $(this).attr('id');
  var modal_img_id = 'modal_' + img_id;
  console.log(img_id);
  console.log(modal_img_id);
  var src = $(`#${modal_img_id}`).attr('src')
  $('.bigimg').children().attr('src', src);


  var modal = document.getElementById( 'modal01' );
  $( modal ).fadeIn( 300 );
  return false;
});

  // モーダルウィンドウを閉じる

$(document).on("click", '.js-modal-close', function(){
    console.log('とじる')
    var modal = document.getElementById( 'modal01' );
    $( modal ).fadeOut( 300 );
    return false;
  });
