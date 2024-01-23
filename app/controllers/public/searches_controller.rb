class Public::SearchesController < ApplicationController
  
  def search
    search_word = params[:word]
      
    @users = User.where("name LIKE ?", "%#{search_word}%").where(is_active: true).page(params[:page]).per(24)
    @works = Work.where("title LIKE ?", "%#{search_word}%").where(is_published: true).page(params[:page]).per(24)
    @clubs = Club.where("name LIKE ?", "%#{search_word}%").page(params[:page]).per(24)
  end
  
end
