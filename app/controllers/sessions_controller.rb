class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember user
        flash[:success] = "ログインに成功しました"
        redirect_back_or user
      else
        message = "アカウントが有効化されていません。"
        message += "認証メールを確認してください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "ログインに失敗しました。入力情報を確認してください。"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  def easy_login
    user = User.find_by(name: "First User")
    log_in user
    flash[:success] = "テストユーザーとしてログインしました"
    redirect_to root_path
  end
end
