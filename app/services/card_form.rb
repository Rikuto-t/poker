class CardForm
  attr_accessor :hands


  def initialize(hands)
    @hands = hands
  end


  # 役判定メソッド
  def yaku

    answer_array = [] #役判定結果が入る配列の箱

    score = [] #各役のスコアが入る配列の箱

    hands_array = @hands.split(",")
    hands_array.each do |hand|
      hand_array = hand.split #1組のハンドを文字列から配列にしたもの
      hand_num_array = []
      hand_array.each do |hand|
        hand_num_array << hand[1, 2].to_i
      end
      hand_num_array = [hand_array[0][1, 2].to_i, hand_array[1][1, 2].to_i, hand_array[2][1, 2].to_i, hand_array[3][1, 2].to_i, hand_array[4][1, 2].to_i].sort #上の配列から数字のみ抜き出し、昇順に変換した配列にしたもの

      #同じ数字のカードをカウントしてpairs_arrayに配列として入れる
      x = 1
      pairs_array = Array.new
      while x < 14
        if hand_num_array.count {|n| n == x} > 1
          pairs_array.push(hand_num_array.count {|n| n == x})
        end
        x += 1
      end

      if hand_array[0][0, 1] == hand_array[1][0, 1] && hand_array[1][0, 1] == hand_array[2][0, 1] && hand_array[2][0, 1] == hand_array[3][0, 1] && hand_array[3][0, 1] == hand_array[4][0, 1] #フラッシュ系判定
        if hand_num_array[4] - hand_num_array[0] == 4 || hand_num_array == [1, 10, 11, 12, 13]
          answer_array.push({hand: hand, answer: "ストレートフラッシュ", best: false})
          score.push(9)
        else
          answer_array.push({hand: hand, answer: "フラッシュ", best: false})
          score.push(6)
        end
      elsif hand_num_array[4] - hand_num_array[0] == 4 || hand_num_array == [1, 10, 11, 12, 13]
        answer_array.push({hand: hand, answer: "ストレート", best: false})
        score.push(5)
      elsif pairs_array == [4]
        answer_array.push({hand: hand, answer: "4カード", best: false})
        score.push(8)
      elsif pairs_array == [2, 3] || pairs_array == [3, 2]
        answer_array.push({hand: hand, answer: "フルハウス", best: false})
        score.push(7)
      elsif pairs_array == [3]
        answer_array.push({hand: hand, answer: "3カード", best: false})
        score.push(4)
      elsif pairs_array == [2, 2]
        answer_array.push({hand: hand, answer: "2ペア", best: false})
        score.push(3)
      elsif pairs_array == [2]
        answer_array.push({hand: hand, answer: "ワンペア", best: false})
        score.push(2)
      else
        answer_array.push({hand: hand, answer: "ハイカード", best: false})
        score.push(1)
      end
    end

    # # 一番強いカードの:bestをtrueに変更
    # answer_array[score.index(score.max)][:best] = true

    # 戻り値
    answer_array
  end
end

# バリデーション
class Hand < ApplicationRecord


  include ActiveModel::Model

  attr_accessor :content

  validates :content, presence: {message: '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'}

  validate :hand_num
  validate :hand_form
  validate :my_unique

  ##以下自作バリデーション
  # 手札入力が正しい形かチェックするバリデーション
  def hand_form
    hands = content
    hands_array = hands.split(",")
    x = 1
    hands_array.each do |hand|
      i = 1
      hand_array = hand.split
      while i <= 5
        solo_hand = hand_array[i - 1]
        unless solo_hand =~ /^[SDHC][1-9]$/ || solo_hand =~ /^[SDHC]1[1-3]$/

          # 以下コメントアウトは複数組受付時のエラー
          # record.errors.add(attribute, "#{x}組目の#{i}番目のカード文字が不正です (#{solo_hand})")
          errors.add(:content, "#{i}番目のカード文字が不正です (#{solo_hand})")
        end
        i = i + 1
      end
      x = x + 1
    end
  end

  #手札の枚数確認バリデーション
  def hand_num
    hands = content
    hands_array = hands.split(",")
    hands_array.each do |hand|
      unless hand.split.length == 5
        errors.add(:content, "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）")
      end
    end
  end

  # 重複チェックバリデーション
  def my_unique
    hands = content
    hands_array = hands.split(",")
    hands_array.each do |hand|
      hand_array = hand.split
      errors.add(:content, "同じカードが入力されています") if hand_array[0] == hand_array[1] || hand_array[1] == hand_array[2] || hand_array[2] == hand_array[3] || hand_array[3] == hand_array[4]
    end
  end


end

