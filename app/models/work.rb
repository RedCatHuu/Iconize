class Work < ApplicationRecord
  
  belongs_to :user
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: :all_blank
  has_one_attached :base_image
  
  validates :name, :base_image, presence: true
  
  def qty_item
    quantity = self.items.size
    quantity = quantity - 1
  end 
  
end
