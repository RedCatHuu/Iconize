class Report < ApplicationRecord
  
  belongs_to :work
  belongs_to :user
  
  validates :type, presence: true
  validates :comment, presence: true, length: {maximum: 400}
  # typeカラムはactive_recordで既に使われており、エラー回避のため記入
  self.inheritance_column = :type_disabled
  
  enum type: {
    reprint: 0,
    anti_social: 1,
    sexual: 2,
    others: 3
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
  
  def solved?
    case self.status
    when 0
      "未処理"
    when 1
      "処理中"
    when 2
      "解決済み"
    end 
  end 
    
  
end
