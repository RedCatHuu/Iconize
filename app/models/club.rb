class Club < ApplicationRecord
  
  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :introduction, length: {maximum: 400}
  
  has_many :works,          dependent: :destroy
  has_many :permits,        dependent: :destroy
  has_many :user_clubs
  has_many :users,          through: :user_clubs
  has_many :club_comments,  dependent: :destroy
  has_many :unpermited_users, through: :permits, source: :user
  
  has_one_attached :club_image
  
  def get_club_image(width, height)
    unless club_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      club_image.attach(io: File.open(file_path), filename: 'no-image.jpg')
    end
    club_image.variant(resize_to_limit: [width, height]).processed
  end 
  
  def member?(user)
    users.include?(user)
  end
  
end
