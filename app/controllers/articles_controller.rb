class ArticlesController < ApplicationController
  before_action :login_required, only: [:index, :create, :new, :edit, :update, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    if params[:tag]
      @tag_name = params[:tag]
      @articles = Article.tagged_with(params[:tag]).page(params[:page]).per(20)
    else
      @tag_name = "全ての記事"
      @articles = Article.includes(:tags).page(params[:page]).per(20)
    end
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def show
    @article = Article.find_by(id: params[:id])
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
    @article = current_user.articles.find_by(id: params[:id])
    @categories = Category.all
  end

  def update
    @article = current_user.articles.find_by(id: params[:id])

    if @article.update_attributes(article_params)
      flash[:success] = "記事を編集しました"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "記事を削除しました"
    redirect_to request.referrer || root_url
  end

  private 
    def article_params
      params.require(:article).permit(:title, :content, :thumbnail, :category_id, :tag_list)
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
  
end
