class Item < ApplicationRecord
  belongs_to :work
  has_many_images :images
  has_many_images :thumbnails
  
  validates :genre, presence: true
end
