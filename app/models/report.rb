class Report < ApplicationRecord
  
  belongs_to :work
  belongs_to :user
  
  validates :type, presence: true
  validates :comment, presence: true, length: {maximum: 400}
  # typeカラムはactive_recordで既に使われており、エラー回避のため記入
  self.inheritance_column = :type_disabled
  
  def which_type
    case self.type
    when 0
      "無断転載をしている"
    when 1
      "反社会的内容を含んでいる"
    when 2
      "性的表現を含んでいる"
    when 3
      "その他"
    end 
  end
  
end
