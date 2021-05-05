$(function () {
    $('#slideDown').on('click', () => {
        $('.delete_button').toggle("slow");
        console.log("クリック！");
    });
});