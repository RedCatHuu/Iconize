class WorkComment < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :comment, length: {maximum: 400}
end
