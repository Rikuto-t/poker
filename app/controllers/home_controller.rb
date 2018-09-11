class HomeController < ApplicationController

  def top
    @hand_valid = Hand.new
  end

  def check


    @hand = params[:hands]

    hand = CardForm.new(@hand)

    @error_messages = hand.myvalid

    if @error_messages == []
      @answers = hand.yaku #役判定メソッドの呼び出し
    else
      render("home/top") #トップページに遷移
    end

  end
end