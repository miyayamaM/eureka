class ApplicationController < ActionController::Base
  include SessionsHelper

  private
    def login_required
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
