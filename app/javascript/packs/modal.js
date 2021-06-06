//モーダル使えないかなあ
$(document).on("click", '.js-modal-img', function(){
  var src = $(this).children().children().attr('src');
  $('.bigimg').children().attr('src', src);

  var modal = document.getElementById( 'modal01' );
  $( modal ).fadeIn( 300 );
  console.log(modal);
  return false;
});

  // モーダルウィンドウを閉じる

$(document).on("click", '.js-modal-close', function(){
    console.log('とじる')
    var modal = document.getElementById( 'modal01' );
    $( modal ).fadeOut( 300 );
    return false;
  });
