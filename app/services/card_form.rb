class CardForm

  attr_accessor :hands

  def initialize(hands)
    @hands = hands
  end

  # 役判定メソッド
  def yaku

    answer_array = [] #役判定結果が入る配列の箱

    hand_array = @hands.split #入力されたハンドを文字列から配列にしたもの

    hand_num_array = [] #手札の数字のみが入る配列の空箱
    hand_array.each do |hand| #hand_num_arrayに手札の数字のみが入る処理
      hand_num_array << hand[1, 2].to_i
    end
    hand_num_array = hand_num_array.sort

    hand_suit_array = [] #手札の数字のみが入る配列の空箱
    hand_array.each do |hand| #hand_num_arrayに手札の数字のみが入る処理
      hand_suit_array << hand[0, 1]
    end

    #同じ数字のカードをカウントしてpairs_arrayに配列として入れる
    x = 1
    pairs_array = []
    while x < 14
      if hand_num_array.count {|n| n == x} > 1
        pairs_array.push(hand_num_array.count {|n| n == x})
      end
      x += 1
    end

    @score = [] #各役のスコアを入れる箱

    if hand_suit_array.uniq.length == 1 #フラッシュ系判定
      if hand_num_array[4] - hand_num_array[0] == 4 || hand_num_array == [1, 10, 11, 12, 13]
        answer_array = [{hand: @hands, answer: "ストレートフラッシュ", best: false}]
        @score << 9
      else
        answer_array.push({hand: @hands, answer: "フラッシュ", best: false})
        @score << 6
      end
    elsif hand_num_array[4] - hand_num_array[0] == 4 || hand_num_array == [1, 10, 11, 12, 13]
      answer_array.push({hand: @hands, answer: "ストレート", best: false})
      @score << 5
    elsif pairs_array == [4]
      answer_array.push({hand: @hands, answer: "4カード", best: false})
      @score << 8
    elsif pairs_array.sort == [2, 3]
      answer_array.push({hand: @hands, answer: "フルハウス", best: false})
      @score << 7
    elsif pairs_array == [3]
      answer_array.push({hand: @hands, answer: "3カード", best: false})
      @score << 4
    elsif pairs_array == [2, 2]
      answer_array.push({hand: @hands, answer: "2ペア", best: false})
      @score << 3
    elsif pairs_array == [2]
      answer_array.push({hand: @hands, answer: "ワンペア", best: false})
      @score << 2
    else
      answer_array.push({hand: @hands, answer: "ハイカード", best: false})
      @score << 1
    end



    
    # 戻り値
    answer_array
  end

  def judge_strength
    # 一番強いカードの:bestをfalseからtrueに変更
    y = 0
    while y < @score.length
      if @score[y] == @score.max
        answer_array[y][:best] = true
      end
      y += 1
    end
  end

  #バリデーションメソッド
  def myvalid
    error_messages = []
    hand_array = @hands.split

    if @hands == ""
      error_messages << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)"
    end
    unless hands.split.length == 5
      error_messages << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)"
    end
    i = 1
    while i <= 5
      solo_hand = hand_array[i - 1]
      unless solo_hand =~ /^[SDHC][1-9]$/ || solo_hand =~ /^[SDHC]1[0-3]$/
        error_messages << "#{i}番目のカード文字が不正です (#{solo_hand})"
      end
      i = i + 1
    end
    error_messages << "同じカードが入力されています" if hand_array[0] == hand_array[1] || hand_array[1] == hand_array[2] || hand_array[2] == hand_array[3] || hand_array[3] == hand_array[4]

    return error_messages
  end
end





