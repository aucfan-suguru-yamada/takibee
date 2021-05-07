$(function () {
    $('#picture_edit_button').on('click', () => {
        $('.picture_delete_button').slideToggle(500);
        console.log("クリック！");
    });

    $('#item_edit_button').on('click', () => {
        $('.item_delete_button').slideToggle(500);
        console.log("クリック！");
    });
});