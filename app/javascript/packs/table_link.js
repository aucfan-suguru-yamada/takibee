//jQuery.js（もしくは対象HTMLの<script>タグ内に記述）
$(function() {
  //clickable-rowクラスの行をマウスオーバーするとカーソルをポインターに変更
  $(".clickable-row").css("cursor","pointer").click(function() {
  //クリックで「data-href」のリンク先へ遷移
    window.location = $(this).data("link");
  });
});