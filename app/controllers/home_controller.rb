class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path if not user_signed_in?
  end
  # Using sign_out causes problems with devise, so using logout instead
  def logout
    sign_out current_user
    redirect_to new_user_session_path
  end
end
