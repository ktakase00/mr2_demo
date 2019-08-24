class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

  helper_method :'logged_in?'

  def logged_in?
    @me.present?
  end
end
