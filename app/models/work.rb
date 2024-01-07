class Work < ApplicationRecord
  
  belongs_to :user
  has_many :items
  
  has_one_attached :base_image
  
  validates :name, :base_image, presence: true
  
  def size
    self.images.count
  end 
  
end
