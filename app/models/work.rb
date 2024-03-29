class Work < ApplicationRecord
  include Order
  
  validates :title, :thumbnail, presence: true
  validates :title, length: {maximum: 30}
  validates :caption, length: {maximum: 400}
  
  # optional: trueによってuser, clubのnilを許可する
  belongs_to :user,           optional: true
  belongs_to :club,           optional: true
  has_many :items,            dependent: :destroy
  has_many :favorites,        dependent: :destroy
  has_many :read_counts,      dependent: :destroy
  has_many :work_comments,    dependent: :destroy
  has_many :reports,          dependent: :destroy
  has_many :favorited_users,  through: :favorites, source: :user
  
  
  accepts_nested_attributes_for :items, reject_if: :all_blank
  has_one_attached :thumbnail
  
  def items_qty
    quantity = self.items.size
    quantity = quantity - 1
  end 
  
  def total
    9 - items_qty
  end 
  
  # 投稿時間（年/月/日 時間:分:秒）
  def y_to_s
    self.created_at.strftime('%Y/%m/%d %H:%M:%S')
  end
  
  # 投稿時間（年/月/日 時間:分）
  def y_to_m
    self.created_at.strftime('%Y年%m月%d日 %H:%M')
  end
  
  def is_published?
    if self.is_published
      "公開中"
    else
      "非公開中"
    end 
  end 
  
  def get_thumbnail(width, height)
    thumbnail.variant(resize_to_limit: [width, height]).processed
  end 
  
  def favorited_by?(user)
    self.favorites.exists?(user_id: user.id)
  end 
  
  def self.public
    where(is_published: true)
  end
  
end
