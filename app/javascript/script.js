/* global $*/

document.addEventListener("turbolinks:load", function() {
  $(document).ready(function(event){
    
    // タブの切り替え
    $('.tab-menu a').on('click', function(event) {
      $(".tab-contents .area").hide();
      $(".tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
    
    // 作品投稿画面のフォーム追加
    $('#add-form').on('click', function(){
      for (let nth_form = 0; nth_form <= 9; nth_form++){
        let current_form = $('#form-number-' + nth_form );
        if (current_form.hasClass('non-active-form')){
          current_form.addClass('active-form');
          current_form.removeClass('non-active-form');
          break;
        }
      }
    })
    
    // 作品投稿画面のフォーム削除
    $('#remove-form').on('click', function(){
      for (let nth_form = 9; nth_form >= 0; nth_form--){
        if ($('#form-number-' + nth_form ).hasClass('active-form')){
          $('#form-number-' + nth_form).removeClass('active-form');
          $('#form-number-' + nth_form ).addClass('non-active-form');
          $('#form-number-' + nth_form ).val('');
          break;
        }
      }
    })
    
  })
})