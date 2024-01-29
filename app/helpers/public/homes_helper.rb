module Public::HomesHelper
  
  # 桁数を返す
  def digit_count(number)
    return 1 if number == 0
    Math.log10(number).to_i + 1
  end
  
  # 2桁の数字を2つに分ける。
  def split_two_digit(number)
    digits = number.to_s.split('').map do |num|
      num.to_i
    end
    return digits[0], digits[1]
  end
  
  # 漢数字に変換
  def convert_to_kanji(number)
    kanji_numbers = {
      1 => '一',
      2 => '二',
      3 => '三',
      4 => '四',
      5 => '五',
      6 => '六',
      7 => '七',
      8 => '八',
      9 => '九',
      0 => '十'
    }
    
    case digit_count(number)
    when 1
      return kanji_numbers[number]
    when 2
      if number == 10
        return "十"
      elsif number.between?(11, 19)
        "十" + kanji_numbers[split_two_digit(number)[1]]
      elsif [20, 30, 40, 50, 60, 70, 80, 90].include?(number)
        kanji_numbers[split_two_digit(number)[0]] + kanji_numbers[split_two_digit(number)[1]]
      else
        kanji_numbers[split_two_digit(number)[0]] + "十" + kanji_numbers[split_two_digit(number)[1]]
      end
    end 
      
  end
  
  def chapter(number)
    "第" + convert_to_kanji(number) + "章"
  end
  
  def article(number)
    "第" + convert_to_kanji(number) + "条"
  end
  
  def paragraph(number)
    convert_to_kanji(number)
  end 

end
