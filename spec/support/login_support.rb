# frozen_string_literal: true

module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link 'ログイン', match: :first
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログインする'
  end

  def sign_out
    find('.dropdown-toggle').click
    click_on 'ログアウト'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
