class Item < ApplicationRecord
  belongs_to :work
  
  has_many_attached :images
  has_many_attached :thumbnails
  
  validates :genre, presence: true
  
  def qty_image
    quantity = self.images.size
    quantity = quantity - 1
  end 
  
end
