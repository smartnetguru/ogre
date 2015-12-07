class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path if not user_signed_in?
  end
end
