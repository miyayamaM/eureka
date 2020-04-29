class UsersController < ApplicationController
  before_action :login_required, only: [:index, :edit, :update, :destroy, :show, :following, :followers]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @q = User.where(activated: true).ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end 

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page]).per(20)
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = "アカウント認証メールを送信しました。受信メールを確認し、アカウントを有効化してください"
      redirect_to root_url
    else
      render new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を変更しました"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "退会しました。ご利用ありがとうございました。"
    redirect_to root_url
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end
  
  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

end
