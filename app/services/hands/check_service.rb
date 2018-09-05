module Hands
  module CheckService

    module_function

    def check_straight(hand)
      i = 1
      n = 1
      while i <= 9
        straight_flash_hand = [n,n+=1,n+=1,n+=1,n+=1]
        n -= 3
        i += 1
        if straight_flash_hand == hand
          return true
        end
      end
      if hand === [1,2,3,4,13] || hand === [1,2,3,12,13] || hand === [1,2,11,12,13] || hand === [1,10,11,12,13]
        return true
      end

    end


    def check_hands(hands)
      Hand.new.set_hands(hands)

      hands_array = hands.split(",")




      hands_array.each do |hand|
        hand_array = hand.split #1組のハンドを文字列から配列にしたもの
        hand_num_array = [hand_array[0][1,2].to_i,hand_array[1][1,2].to_i,hand_array[2][1,2].to_i,hand_array[3][1,2].to_i,hand_array[4][1,2].to_i].sort #上の配列から数字のみ抜き出し、昇順に変換した配列にしたもの

        #同じ数字のカードをカウントしてpairs_arrayに配列として入れる
        x = 1
        pairs_array = Array.new
        while x < 14
          if hand_num_array.count{|n| n == x} > 1
            pairs_array.push(hand_num_array.count{|n| n == x})
          end
          x += 1
        end

        if hand_array[0][0,1] == hand_array[1][0,1] && hand_array[1][0,1] == hand_array[2][0,1] && hand_array[2][0,1] == hand_array[3][0,1] && hand_array[3][0,1] == hand_array[4][0,1] #フラッシュ系判定
          if check_straight(hand_num_array)
            return "ストレートフラッシュ"
          else
            return "フラッシュ"
          end
        elsif check_straight(hand_num_array)
          return "ストレート"
        elsif pairs_array == [4]
          return "4カード"
        elsif pairs_array == [2,3] || pairs_array == [3,2]
           return "フルハウス"
        elsif pairs_array == [3]
          return "3カード"
        elsif pairs_array == [2,2]
          return "2ペア"
        elsif pairs_array == [2]
          return  "2カード"
        else
          return "ハイカード"
        end
      end
    end
  end
end


