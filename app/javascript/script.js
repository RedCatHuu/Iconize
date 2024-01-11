/* global $*/

// タブの切り替え
document.addEventListener("turbolinks:load", function() {
  $(document).ready(function(event){
    $('.tab-menu a').on('click', function(event) {
      $(".tab-contents .area").hide();
      $(".tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
  })
})