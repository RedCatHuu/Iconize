class WorkComment < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :comment, presence: true, length: {maximum: 400}
end
