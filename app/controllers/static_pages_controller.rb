class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @feed_items = current_user.feed.page(params[:page]).per(20)
    end
  end
  
  def rule
  end

  def about
  end
end
