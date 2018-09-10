class HomeController < ApplicationController
  include CardForm


  def top
    @hand = Hand.new
    @hand_valid = Hand.new
  end


  def check
    if params[:hands].nil?
      redirect_to("/")
    else
      hand = CardForm.new(params[:hands])

      @hand_valid = Hand.new(content: params[:hands])
      if @hand_valid.valid?
        @answers = hand.yaku
      else
        render("home/top")
      end
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