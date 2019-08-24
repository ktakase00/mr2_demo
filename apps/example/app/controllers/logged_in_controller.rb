class LoggedInController < ApplicationController
  before_action :check_session

  def check_session
    @me = User.find_by({ id: session[:user_id] }) if session[:user_id].present?
    redirect_to new_session_path if @me.nil?
  end
end
