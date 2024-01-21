/* global $*/

document.addEventListener("turbolinks:load", function() {
  $(document).ready(function(event){
    
    // トグル制御
    $(".openbtn").click(function () {
      $(this).toggleClass('active');
      $("#horizontal-nav").toggleClass('panelactive');
    });
    
    // タブの切り替え
    $('.tab-menu a').on('click', function(event) {
      $(".tab-contents .area").hide();
      $(".tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
    
        // タブの切り替え　User
    $('.user-tab-menu a').on('click', function(event) {
      $(".user-tab-contents .area").hide();
      $(".user-tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
    
    // サムネイル画像のファイル名表示
    $('.input-thumbnail').on('change', function () {
      let file = $(this).prop('files')[0];
      $('#new-thumbnail').text(file.name);
    });
    
    // 作品投稿画面のフォーム追加（アイテム欄）
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
        let current_form = $('#form-number-' + nth_form );
        if (current_form.hasClass('active-form')){
          current_form.removeClass('active-form');
          current_form.addClass('non-active-form');
          let itemGenreInput = current_form.find('input[name$="[genre]"]');
          let itemImagesInput = current_form.find('input[name$="[images][]"]');
    
          if (itemGenreInput.length > 0) {
            itemGenreInput.val('');
          }
    
          if (itemImagesInput.length > 0) {
            itemImagesInput.val('');
          }
          break;
        }
      }
    })
    
    // 作品投稿画面のイメージ欄のフォーム追加・削除、ファイル名表示
    for (let nth_form = 0; nth_form <= 9; nth_form++){
      
      // 追加
      $('.add-image-form-' + nth_form).on('click', function(){
        for (let nth_image_form = 0; nth_image_form <= 9; nth_image_form++){
          let current_form = $('.image-form-number-' + nth_form + '-' + nth_image_form );
          if (current_form.hasClass('non-active-form')){
            current_form.addClass('active-image-form');
            current_form.removeClass('non-active-form');
            break;
          }
        }
      })
          
      // 削除
      $('.remove-image-form-' + nth_form).on('click', function(){
        for (let nth_image_form = 9; nth_image_form >= 0; nth_image_form--){
          let current_form = $('.image-form-number-' + nth_form + '-'  + nth_image_form );
          if (current_form.hasClass('active-image-form')){
            current_form.removeClass('active-image-form');
            current_form.addClass('non-active-form');
            let itemImagesInput = current_form.find('input[name$="[images][]"]');
            if (itemImagesInput.length > 0) {
              itemImagesInput.val('');
            }
            break;
          }
        }
      })
      
      
      // アイテム画像のファイル名表示
      for (let nth_image_form = 0; nth_image_form <= 9; nth_image_form++){
        $('#item-file-' + nth_form + '-' + nth_image_form).on('change', function () {
            let file = $(this).prop('files')[0];
            $('.file-name-' + nth_form + '-' + nth_image_form).text(file.name);
        });
      }
      
    }
    
    // ファイル名表示
    $('.file-name-input').on('change', function () {
      let file = $(this).prop('files')[0];
      $('.file-name-output').text(file.name);
    });
    
    

    
    
    
  })
})