class User < ApplicationRecord
  
  include Order
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 400}
  
  has_one_attached :profile_image
  has_many :works,            dependent: :destroy
  has_many :permits,          dependent: :destroy
  has_many :user_clubs,       dependent: :destroy
  has_many :clubs,            through: :user_clubs
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
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end 
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end 
  
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end 
  
  def following?(user)
    following.include?(user)
  end 
  
  def status
    if is_active
      "有効"
    else
      "無効"
    end 
  end 
  
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end 
  end 

  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  def active_for_authentication?
    super && is_active?
  end
  
  def self.active
    where(is_active: :true)
  end
  
end
