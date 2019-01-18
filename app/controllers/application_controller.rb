class ApplicationController < ActionController::Base

  private
  def logged_in?
    if !user_signed_in?
      redirect_to recipes_path
    end
  end
end
