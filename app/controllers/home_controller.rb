class HomeController < ApplicationController
  include CardForm


  def top
    @hand = Hand.new
  end


  def check

    @input_hands = params[:hands]
    hands = params[:hands]

    @hand = Hand.new(content: hands)

    if @hand.valid?
      hand = CardForm.new(hands)
      @answers = hand.yaku
    else
      render("home/top")
    end

    # hands = hands || "C5 H5 D5 D12 C10,C5 H5 D5 D12 C10"

    # @answer = Hands::CheckService.check_hands(hands)


  end
end