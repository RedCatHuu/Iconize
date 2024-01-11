class Work < ApplicationRecord
  
  belongs_to :user
  belongs_to :club
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: :all_blank
  has_one_attached :base_image
  
  validates :title, :base_image, presence: true
  
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
  
end
