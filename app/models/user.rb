class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 400}
  
  has_one_attached :profile_image
  has_many :works,            dependent: :destroy
  has_many :permits,          dependent: :destroy
  has_many :user_clubs
  has_many :clubs,            through: :user_club
  has_many :favorites,        dependent: :destroy
  has_many :favorited_works,  through: :favorites, source: :work
  has_many :read_counts,      dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships
  has_many :work_comments,    dependent: :destroy
  has_many :club_comments,    dependent: :destroy
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.jpg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end 
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end 
  
  def unfollow(user)
    passive_relationships.find_by(follow_id: user.id).destroy
  end 
  
  def following?(user)
    following.include?(user)
  end 
  
end
