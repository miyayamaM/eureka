class UsersController < ApplicationController
  def index
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
      flash[:success] = "ユーザ登録に成功しました"
      redirect_to user_path(@user)
    else
      render new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
