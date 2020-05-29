# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :user_setup, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'パスワード再設定メールを送信しました。'
      redirect_to root_url
    else
      flash[:danger] = 'メールアドレスが登録されていません'
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      flash[:success] = 'パスワードが再設定されました'
      redirect_to login_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_setup
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = 'リンクの期限が切れています。もう一度メールを送信してください'
    redirect_to new_password_reset_url
  end
end
