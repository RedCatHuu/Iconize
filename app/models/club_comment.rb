class ClubComment < ApplicationRecord
  
  include Order
  
  belongs_to :user
  belongs_to :club
  
  validates :comment, presence: true, length: {maximum: 400}
  
  
  # 投稿時間（年/月/日 時間:分）
  def y_to_m
    self.created_at.strftime('%Y年%m月%d日 %H:%M')
  end
  
end
