$(document).on('turbolinks:load',function(){
  function imgPreView(event){
    var fileReader = new FileReader();
    fileReader.onload = (function() {
      document.getElementById('user_avatar').src = fileReader.result;
    });
    fileReader.readAsDataURL(event.files[0]);
    console.log("avatar")
  };
});