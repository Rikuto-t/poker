class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :show_flash

  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404
  def render_404
    redirect_to "/"
  end

  private


  def show_flash
    flash.now[:notice] = "Found the about page!" if request.path == '/pages/about'
  end
end
