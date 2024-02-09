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
    
    // 作品投稿画面のフォーム削除（アイテム欄）
    $('#remove-form').on('click', function(){
      for (let nth_form = 9; nth_form >= 0; nth_form--){
        let current_form = $('#form-number-' + nth_form );
        if (current_form.hasClass('active-form')){
          current_form.toggleClass('active-form non-active-form');
          
          let itemGenreInput = current_form.find('input[name$="[genre]"]');
          let itemImagesInput = current_form.find('input[name$="[images][]"]');
          let itemImagesName = current_form.find('p[class*="file-name"]');

          if (itemGenreInput.length > 0) {
            itemGenreInput.val('');
          }
    
          if (itemImagesInput.length > 0) {
            // 実際にファイルを削除
            itemImagesInput.val(null);
            // 表示されているファイル名を削除
            itemImagesName.text('選択されていません');
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
            current_form.toggleClass('active-image-form non-active-form');
            break;
          }
        }
      })
          
      // 削除
      $('.remove-image-form-' + nth_form).on('click', function(){
        for (let nth_image_form = 9; nth_image_form >= 0; nth_image_form--){
          let current_form = $('.image-form-number-' + nth_form + '-'  + nth_image_form );
          if (current_form.hasClass('active-image-form')){
            current_form.toggleClass('active-image-form non-active-form');
            
            let itemImagesInput = current_form.find('input[name$="[images][]"]');
            let itemImagesName = current_form.find('p[class*="file-name"]');
            if (itemImagesInput.length > 0) {
              itemImagesInput.val(null);
              itemImagesName.text('選択されていません');
            }
            break;
          }
        }
      })
      
      
      // アイテム画像のファイル名表示。ファイルフィールドはidで識別する他なく、jsの使いまわしができないため、id部分は適宜追加。
      for (let nth_image_form = 0; nth_image_form <= 9; nth_image_form++){
        $('#item-file-' + nth_form + '-' + nth_image_form + ',' + '#edit-item-file-' + nth_form + '-' + nth_image_form
        ).on('change', function () {
            let file = $(this).prop('files')[0];
            $('.file-name-' + nth_form + '-' + nth_image_form).text(file.name);
        });
      }
      
    }
    
    // 未入力の場合、submitを阻止
    $('.form-validation').on('submit', function(event) {
      if ($('.form-validation .add-validation').val().trim() === '') {
        event.preventDefault(); 
      }
    });
    
    
    // 文字数制限（長い文字数）
    $('.chara-limit-long').on('input', function(){
      let limit = $(this).data('limit');
      let countNum = $(this).val().length;
      // 制限したいフォームが複数あるため、同一の親要素内にあるoutput-countクラスを探す。
      let output = $(this).closest('.chara-limit-container').find('.output-count');
      output.text(countNum + '/' + limit + '字');
      
      $('.chara-limit').each(function() {
        if ($(this).val().length > $(this).data('limit')) {
          $('.add-disabled').prop('disabled', true);
          return false;
        } else{
          $('.add-disabled').prop('disabled', false);
        }
      });
      
      if(countNum > limit){
        output.addClass('over-limit');
      } else {
        output.removeClass('over-limit');
      }
      
    });
    
    // 文字数制限（少ない文字数用）
    $('.chara-limit-short').on('input', function(){
      let limit = $(this).data('limit');
      let countNum = $(this).val().length;
      let output = $(this).closest('.chara-limit-container').find('.output-count');
      let overLimit = 0;
      overLimit = countNum - limit;
      
      $('.chara-limit').each(function() {
        if ($(this).val().length > $(this).data('limit')) {
          $('.add-disabled').prop('disabled', true);
          return false;
        } else{
          $('.add-disabled').prop('disabled', false);
        }
      });
      
      if(countNum > limit){
        output.css("display", "block");
        output.text("あと" + overLimit + "文字短くしてください");
      } else {
        output.css("display", "none");
      }
    });
    
    
    // アップロードした画像のファイル名表示
    $('.input-image').on('change', function () {
      let file = $(this).prop('files')[0];
      $('.display-filename').text(file.name);
    });
    
    // プレビュー(user.edit)
    $('.input-image').on('change', function(event) {
      var input = event.target;
      var reader = new FileReader();
  
      reader.onload = function(){
        var dataURL = reader.result;
        var preview = $('.user-image-preview');
        preview.attr('src', dataURL);
      };
  
      // 選択されたファイルを読み込む
      reader.readAsDataURL(input.files[0]);
    });
    
    // プレビュー(user.edit以外)
    $('.input-image').on('change', function(event) {
      var input = event.target;
      var reader = new FileReader();
  
      reader.onload = function(){
        var dataURL = reader.result;
        var preview = $('.display-image');
        preview.attr('src', dataURL);
      };
      reader.readAsDataURL(input.files[0]);
    });
    
    
  });
});

