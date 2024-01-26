class Public::HomesController < ApplicationController
  def top
    @works = Work.where(is_published: true).order(created_at: :desc).limit(6)
  end

  def about
  end
end
