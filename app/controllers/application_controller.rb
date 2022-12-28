class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ExceptionHandler

  def count
    params[:count] || 20
  end

  def page
    params[:page] || 1
  end
end
