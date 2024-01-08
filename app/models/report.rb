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
