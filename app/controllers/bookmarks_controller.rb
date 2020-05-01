class BookmarksController < ApplicationController
  before_action :login_required

  def create
    @article = Article.find(params[:article_id])
 
    current_user.bookmark(@article)
    respond_to do |format|
      format.html {redirect_to current_user}
      format.js
    end
  end

  def destroy
    @article = Article.find(params[:id])

    current_user.unbookmark(@article)
    respond_to do |format|
      format.html {redirect_to current_user}
      format.js
    end
  end
end
