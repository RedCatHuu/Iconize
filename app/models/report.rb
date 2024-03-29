class Report < ApplicationRecord
  
  belongs_to :work
  belongs_to :user
  
  validates :type, presence: true
  validates :comment, presence: true, length: {maximum: 1000}
  # typeカラムはactive_recordで既に使われており、エラー回避のため記入
  self.inheritance_column = :type_disabled
  
  enum type: {
    reprint: 0,
    anti_social: 1,
    sexual: 2,
    violent: 3,
    others: 4
  }
  
  enum status: {
    waiting: 0,
    working: 1,
    solved: 2
  }
  
   # 通報時間（年/月/日 時間:分:秒）
  def y_to_s
    self.created_at.strftime('%Y/%m/%d %H:%M:%S')
  end
  
  
end
