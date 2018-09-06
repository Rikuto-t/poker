
# 手札の入力が正しい形か判別するバリデーション
class HandValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    hands = value
    hands_array = hands.split(",")
    x = 1
    hands_array.each do |hand|

      i = 1
      hand_array = hand.split
      while i <= 5
        solo_hand = hand_array[i-1]
        unless solo_hand =~ /[SHDC][1-9]/ && solo_hand[1,2].to_i < 14 || solo_hand =~ /[SHDC][1][1-3]/ && solo_hand[1,2].to_i < 14
          record.errors.add(attribute, "#{x}組目の#{i}番目のカード文字が不正です (#{solo_hand})")
        end
        i = i + 1
      end
      x = x + 1
    end
  end
end

# 手札の枚数が5枚あるか確認するバリデーション
class HandNumValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    hands = value
    hands_array = hands.split(",")
    x = 1
    hands_array.each do |hand|
      unless hand.split.length == 5
        record.errors.add(attribute, "5つのカード指定文字を半角スペース区切りで入力してください。カンマ区切りで複数の組み合わせも判定できます。（例：S1 H3 D9 C13 S11,C5 H5 D5 D12 C10）")
      end

    end
  end
end

