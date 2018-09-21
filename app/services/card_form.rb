class CardForm

  include HomeHelper
  attr_accessor :hands
  attr_accessor :error_messages


  # エラーメッセージ
  ERR_MSG_INVALID_HANDS = '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)'
  ERR_MSG_DUPLICATE_HANDS = '同じカードが入力されています'

  # 役
  HAND_STRAIGHT_FLASH = 'ストレートフラッシュ'
  HAND_FLASH = 'フラッシュ'
  HAND_STRAIGHT = 'ストレート'
  HAND_4CARD = '4カード'
  HAND_FULLHOUSE = 'フルハウス'
  HAND_3CARD = '3カード'
  HAND_2PAIR = '2ペア'
  HAND_1PAIR = 'ワンペア'
  HAND_HIGHCARD = 'ハイカード'

  # 役の強さ
  HAND_STRAIGHT_FLASH_SCORE = 9
  HAND_FLASH_SCORE = 6
  HAND_STRAIGHT_SCORE = 5
  HAND_4CARD_SCORE = 8
  HAND_FULLHOUSE_SCORE = 7
  HAND_3CARD_SCORE = 4
  HAND_2PAIR_SCORE = 3
  HAND_1PAIR_SCORE = 2
  HAND_HIGHCARD_SCORE = 1


  def initialize(hands)
    @hands = hands
    @hand_array = @hands.split
  end

  # 役判定メソッド
  def yaku

    hands_num = [] #手札の数字のみが入る配列の空箱
    hands_suit = [] #手札のスートのみが入る配列の空箱

    @hand_array.each do |hand|
      hands_num << hand[1, 2].to_i # 数字のみの配列の作成
      hands_suit << hand[0, 1] # スートのみの配列の作成
    end

    # 数字のみの配列をソート
    hands_num = hands_num.sort

    #同じ数字のカードをカウントしてpairsに配列として入れる
    pairs = []
    (1..13).each do |i|
      hands_num_count = hands_num.count {|n| n == i}
      pairs << hands_num_count if hands_num_count > 1
    end

    # メイン役判定
    return  {hand: @hands, answer: HAND_STRAIGHT_FLASH, score: HAND_STRAIGHT_FLASH_SCORE} if hands_suit.uniq.length == 1 && hands_num[4] - hands_num[0] == 4 || hands_num == [1, 10, 11, 12, 13]

    if hands_suit.uniq.length == 1
       {hand: @hands, answer: HAND_FLASH, score: HAND_FLASH_SCORE}
    elsif hands_num[4] - hands_num[0] == 4 || hands_num == [1, 10, 11, 12, 13]
       {hand: @hands, answer: HAND_STRAIGHT, score: HAND_STRAIGHT_SCORE}
    elsif pairs == [4]
       {hand: @hands, answer: HAND_4CARD, score: HAND_4CARD_SCORE}
    elsif pairs.sort == [2, 3]
       {hand: @hands, answer: HAND_FULLHOUSE, score: HAND_FULLHOUSE_SCORE}
    elsif pairs == [3]
       {hand: @hands, answer: HAND_3CARD, score: HAND_3CARD_SCORE}
    elsif pairs == [2, 2]
       {hand: @hands, answer: HAND_2PAIR, score: HAND_2PAIR_SCORE}
    elsif pairs == [2]
       {hand: @hands, answer: HAND_1PAIR, score: HAND_1PAIR_SCORE}
    else
       {hand: @hands, answer: HAND_HIGHCARD, score: HAND_HIGHCARD_SCORE}
    end

  end


  #バリデーションメソッド
  def get_error_msg

    error_messages = []

    if @hands.empty?
      error_messages << ERR_MSG_INVALID_HANDS
      return error_messages
    end

    if hands.split.length != 5
      error_messages << ERR_MSG_INVALID_HANDS
      return error_messages
    end

    @hand_array.each_with_index do |solo_hand, index|
      error_messages << "#{index + 1}番目のカード文字が不正です (#{solo_hand})" unless solo_hand =~ /^[SDHC][1-9]$/ || solo_hand =~ /^[SDHC]1[0-3]$/
    end

    error_messages << ERR_MSG_DUPLICATE_HANDS if @hand_array.count - @hand_array.uniq.count > 0 && error_messages.empty?


    return error_messages

  end

  # def valid?
  #
  #   @error_messages = []
  #
  #   if @hands.empty?
  #     @error_messages << ERR_MSG_INVALID_HANDS
  #     return false
  #   end
  #
  #   if hands.split.length != 5
  #     @error_messages << ERR_MSG_INVALID_HANDS
  #     return false
  #   end
  #
  #   @hand_array.each_with_index do |solo_hand, index|
  #     @error_messages << "#{index + 1}番目のカード文字が不正です (#{solo_hand})" unless solo_hand =~ /^[SDHC][1-9]$/ || solo_hand =~ /^[SDHC]1[0-3]$/
  #   end
  #
  #   @error_messages << ERR_MSG_DUPLICATE_HANDS if @hand_array.count - @hand_array.uniq.count > 0 && @error_messages.empty?
  #
  #
  #   return false
  #
  # end
  #
  # return true

end





