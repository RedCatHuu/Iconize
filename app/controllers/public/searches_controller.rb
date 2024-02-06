class Public::SearchesController < ApplicationController
  
  def search
    search_word = params[:word]
    @users = User.where("name LIKE ?", "%#{search_word}%").active.page(params[:page]).per(24)
    @works = Work.where("title LIKE ?", "%#{search_word}%").public.page(params[:page]).per(24)
    @works_all = Work.where("title LIKE ?", "%#{search_word}%").public
    @clubs = Club.where("name LIKE ?", "%#{search_word}%").page(params[:page]).per(24)
  end
  
end
