class UsersController < ApplicationController
  before_action :login_required, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end 

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録に成功しました"
      redirect_to user_path(@user)
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

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def login_required
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

end
