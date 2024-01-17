class Public::SearchesController < ApplicationController
  
  def search
    search_word = params[:word]
      
    @users = User.where("name LIKE ?", "%#{search_word}%")
    @works = Work.where("title LIKE ?", "%#{search_word}%")
    @clubs = Club.where("name LIKE ?", "%#{search_word}%")
  end
  
end
