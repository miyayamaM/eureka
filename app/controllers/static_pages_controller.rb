class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @feed_items = current_user.feed.page(params[:page]).per(15)
    else
      @top_articles = Article.find(Bookmark.group(:article_id).order('count(article_id) desc').limit(6).pluck(:article_id))
    end
  end
  
  def rule
  end

  def about
  end
end
