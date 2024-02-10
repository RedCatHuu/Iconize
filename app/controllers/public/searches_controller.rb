class Public::SearchesController < ApplicationController
  
  def search
    search_word = params[:word]
    # @users = User.where("name LIKE ?", "%#{search_word}%").active.page(params[:page]).per(24)
    @users = search_words(search_word, User, "name").active.page(params[:page]).per(24)
    @works = Work.where("title LIKE ?", "%#{search_word}%").public.page(params[:page]).per(24)
    @works_all = Work.where("title LIKE ?", "%#{search_word}%").public
    @clubs = Club.where("name LIKE ?", "%#{search_word}%").page(params[:page]).per(24)
  end
  
  private
  
  def search_words(words, model, column)
    keywords = words.split(/[[:blank:]]+/).select(&:present?)
    # negative_keywords, positive_keywords = keywords.partition(&:start_with?("-"))
    @model = model
    # positive_keywords.each do |keyword|
    keywords.each do |keyword|
      @model = @model.where("#{column} LIKE ?", "%#{keyword}%")
    end
    return @model
  end
  
end
