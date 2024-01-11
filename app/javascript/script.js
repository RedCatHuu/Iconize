/* global $*/
$(document).ready(function(){
  $(".openbtn").click(function () {
      $(this).toggleClass('active');
  });
})

// タブの切り替え
  $(document).ready(function(event){
    $('.tab-menu a').on('click', function(event) {
      $(".tab-contents .area").hide();
      $(".tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
  })
