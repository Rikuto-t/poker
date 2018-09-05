class HomeController < ApplicationController
  def check
    @hand = params[:hand]
  end
end
