# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Eureka メールアドレス確認のお願い'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Eureka パスワード再設定'
  end
end
