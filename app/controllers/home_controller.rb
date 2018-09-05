class HomeController < ApplicationController
  def check

    @hands = params[:hands]
    hands = params[:hands]



    @answer = Hands::CheckService.check_hands(hands)

  end
end