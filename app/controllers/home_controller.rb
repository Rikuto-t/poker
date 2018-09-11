class HomeController < ApplicationController


  def top
    @hand = Hand.new
    @hand_valid = Hand.new
  end


  def check

      @hand_valid = Hand.new(content: params[:hands]) #バリデーションを発動させるためのnew
      # バリデーションの分岐
      if @hand_valid.valid? #バリデーションが通った時
        hand = CardForm.new(params[:hands])
        @answers = hand.yaku #役判定メソッドの呼び出し
      else #バリデーションが通らなかった時
        render("home/top") #トップページに遷移
      end



    # if hand.myvalid?
    #   @answers = hand.yaku
    # else
    #   @error_message="error!"
    #   render("home/top")
    # end


    # hands = hands || "C5 H5 D5 D12 C10,C5 H5 D5 D12 C10"

    # @answer = Hands::CheckService.check_hands(hands)


  end
end