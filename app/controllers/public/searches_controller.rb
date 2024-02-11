class Public::SearchesController < ApplicationController
  
  def search
    @words = params[:word]
    @users = search_words(@words, User, "name").active.page(params[:page]).per(24)
    @works = search_words(@words, Work, "title").public.page(params[:page]).per(24)
    @works_all = search_words(@words, Work, "title").public
    @clubs = search_words(@words, Club, "name").page(params[:page]).per(24)
  end
  
  private
  
  def search_words(words, model, column)
    keywords = words.split(/[[:blank:]]+/).select(&:present?)
    negative_keywords, positive_keywords = keywords.partition { |keyword| keyword.start_with?("-") }
    result = model
    
    positive_keywords.each do |keyword|
      result = result.where("#{column} LIKE ?", "%#{keyword}%")
    end
    
    negative_keywords.each do |keyword|
      result.where!("#{column} NOT LIKE ?", "%#{keyword.delete_prefix("-")}%")
    end
    
    return result
  end
  
end
