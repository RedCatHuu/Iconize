class Work < ApplicationRecord
  
  
  validates :title, :base_image, presence: true
  validates :caption, length: {maximum: 400}
  
  belongs_to :user
  # optional: trueによってclubのnilを許可する
  belongs_to :club,         optional: true
  has_many :items,          dependent: :destroy
  has_many :favorites,      dependent: :destroy
  has_many :read_counts,    dependent: :destroy
  has_many :work_comments,  dependent: :destroy
  
  
  accepts_nested_attributes_for :items, reject_if: :all_blank
  has_one_attached :base_image
  
  def qty_item
    quantity = self.items.size
    quantity = quantity - 1
  end 
  
  # 投稿時間（年/月/日 時間:分:秒）
  def y_to_s
    self.created_at.strftime('%Y/%m/%d %H:%M:%S')
  end
  
  def is_published?
    if self.is_published
      "公開中"
    else
      "非公開中"
    end 
  end 
  
  def get_base_image(width, height)
    base_image.variant(resize_to_limit: [width, height]).processed
  end 
  
  def favorited_by?(user)
    self.favorites.exists?(user_id: user.id)
  end 
  
end
