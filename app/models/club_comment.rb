class ClubComment < ApplicationRecord
  belongs_to :user
  belongs_to :club
  
  validates :comment, length: {maximum: 400}
end
