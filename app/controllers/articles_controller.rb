# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :login_required, only: %i[create new edit update destroy]
  before_action :correct_user, only: :destroy
  before_action :all_categories, only: %i[new create edit update]

  def index
    if params[:tag]
      @tag_name = params[:tag]
      @articles = Article.tagged_with(params[:tag]).page(params[:page]).per(20)
    else
      @tag_name = '全ての記事'
      @articles = Article.includes(:tags).page(params[:page]).per(20)
    end
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user)

    @related_articles = if @article.category_id.nil?
                          Article.where(category_id: nil).where.not(id: @article.id).select(:id, :title, :category_id, :user_id, :created_at).order(Arel.sql('RAND()')).limit(5)
                        else
                          Article.where(category_id: @article.category_id).where.not(id: @article.id).select(:id, :title, :category_id, :user_id, :created_at).order(Arel.sql('RAND()')).limit(5)
                        end
  end

  def create
    @user = current_user
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = '記事が投稿されました!'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @article = current_user.articles.find_by(id: params[:id])
  end

  def update
    @article = current_user.articles.find_by(id: params[:id])

    if @article.update(article_params)
      flash[:success] = '記事を編集しました'
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = '記事を削除しました'
    redirect_to request.referer || root_url
  end

  def result; end

  private

  def article_params
    params.require(:article).permit(:title, :citation, :content, :thumbnail, :category_id, :tag_list)
  end

  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    redirect_to root_url if @article.nil?
  end

  def all_categories
    @categories = Category.all
  end
end
