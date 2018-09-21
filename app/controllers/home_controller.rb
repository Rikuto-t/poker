class HomeController < ApplicationController

  def top

  end

  def check

    @hand = params[:hands]

    hand = CardForm.new(@hand)

    @error_messages = []
    hand.get_error_msg.each do |error|
      @error_messages << error
    end
    
    if hand.get_error_msg.empty?
      @answer = hand.yaku #役判定メソッドの呼び出し
    else
      render("home/top") #トップページに遷移
    end
  end

  # def check
  #
  #   @hand = params[:hands]
  #
  #   hand = CardForm.new(@hand)
  #
  #   @error_messages = hand.error_messages
  #
  #   if hand.valid?
  #     @answer = hand.yaku #役判定メソッドの呼び出し
  #   else
  #     render("home/top") #トップページに遷移
  #   end
  # end
end

