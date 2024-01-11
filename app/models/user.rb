class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 400}
  
  has_one_attached :profile_image
  has_many :works,        dependent: :destroy
  has_many :permits,      dependent: :destroy
  has_many :user_clubs
  has_many :clubs, through: :user_club
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.jpg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end 
  
end
