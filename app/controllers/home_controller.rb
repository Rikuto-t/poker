# require_relative '../services/hands/check2_service'

class HomeController < ApplicationController
  include CardForm

  # require '../services/hands/card_form.rb'


  def check

    @hands = params[:hands]
    hands = params[:hands]

    hands = hands || "C5 H5 D5 D12 C10"

    # @answer = Hands::CheckService.check_hands(hands)


    hand = CardForm.new(hands)
    #
    @answer = hand.yaku

  end
end