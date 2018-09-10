# # 手札の枚数が5枚あるか確認するバリデーション
# class HandNumValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     hands = value
#     hands_array = hands.split(",")
#
#     hands_array.each do |hand|
#       unless hand.split.length == 5
#         record.errors.add(attribute, "handnumエラー")
#       end
#
#     end
#   end
# end


# # 手札の入力が正しい形か判別するバリデーション
# class HandValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     hands = value
#     hands_array = hands.split(",")
#     x = 1
#     hands_array.each do |hand|
#
#       i = 1
#       hand_array = hand.split
#       while i <= 5
#         solo_hand = hand_array[i - 1]
#         unless solo_hand =~ /^[SDHC][1-9]$/ || solo_hand =~ /^[SDHC]1[1-3]$/
#
#
#           # 以下コメントアウトは複数組受付時のエラー
#           # record.errors.add(attribute, "#{x}組目の#{i}番目のカード文字が不正です (#{solo_hand})")
#
#           record.errors.add(attribute, "#{i}番目のカード文字が不正です (#{solo_hand})")
#
#         end
#         i = i + 1
#       end
#       x = x + 1
#     end
#   end
# end

# #手札の重複チェック
# class UniqueValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     hands = value
#     hands_array = hands.split(",")
#     hands_array.each do |hand|
#       hand_array = hand.split
#       record.errors.add(attribute, "同じカードが入力されています") if hand_array[0] == hand_array[1] || hand_array[1] == hand_array[2] || hand_array[2] == hand_array[3] || hand_array[3] == hand_array[4]
#     end
#   end
# end


