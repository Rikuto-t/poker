class HomeController < ApplicationController

  def top
    @hand_valid = Hand.new
  end

  def check
    # @hand_valid = Hand.new(content: params[:hands]) #バリデーションを発動させるためのnew
    # # バリデーションの分岐
    # if @hand_valid.valid? #バリデーションが通った時
    #   hand = CardForm.new(params[:hands])
    #   @answers = hand.yaku #役判定メソッドの呼び出し
    # else #バリデーションが通らなかった時
    #   render("home/top") #トップページに遷移
    # end

    @hand = params[:hands]
    hand = CardForm.new(params[:hands])
    @error_messages = hand.myvalid
    if @error_messages == []
      @answers = hand.yaku #役判定メソッドの呼び出し
    else
      render("home/top") #トップページに遷移
    end






    # hands = hands || "C5 H5 D5 D12 C10,C5 H5 D5 D12 C10"

    # @answer = Hands::CheckService.check_hands(hands)


  end
end