class ClubComment < ApplicationRecord
  belongs_to :user
  belongs_to :club
  
  validates :comment, presence: true, length: {maximum: 400}
end
