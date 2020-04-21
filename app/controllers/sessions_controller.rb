class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      flash[:success] = "ログインに成功しました"
      redirect_to user
    else
      flash.now[:danger] = "ログインに失敗しました。入力情報を確認してください。"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
