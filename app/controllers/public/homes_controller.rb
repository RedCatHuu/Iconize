class Public::HomesController < ApplicationController
  def top
    @works = Work.where(is_published: true).order(created_at: :desc).limit(6)
    @favorited_works = Work
      .where(is_published: true)
      .includes(:favorited_users)
      .order(Arel.sql('(SELECT COUNT(*) FROM favorites WHERE favorites.work_id = works.id) DESC'))
      .limit(6)
  end

  def terms
  end
  
end
