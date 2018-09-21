class HomeController < ApplicationController

  def top

  end

  def check

    @hand = params[:hands]

    hand = CardForm.new(@hand)

    @error_messages = hand.get_error_msg

    if hand.get_error_msg.empty?
      @answer = hand.yaku #役判定メソッドの呼び出し
    else
      render("home/top") #トップページに遷移
    end
  end
end