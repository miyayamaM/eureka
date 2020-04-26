class ArticlesController < ApplicationController
  before_action :login_required, only: [:index,:create, :new, :edit, :update, :destroy]
  before_action :correct_user,   only: :destroy

  def index 
  end

  def new
    @article = Article.new
  end

  def create
    @user = current_user
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = "記事が投稿されました!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
  end

  def destroy
    @article.destroy
    flash[:success] = "記事を削除しました"
    redirect_to request.referrer || root_url
  end

  private 
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
  
end
