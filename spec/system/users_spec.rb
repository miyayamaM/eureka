require 'rails_helper'

RSpec.describe 'Users', type: :system do

  describe 'Signup' do
    it 'is successful with valid information' do
      visit root_path
      click_on '新規登録'

      expect {
        fill_in 'ユーザー名', with: "Tom Brady"
        fill_in 'メールアドレス', with: "tester@example.com"
        fill_in 'パスワード', with: "foobar"
        fill_in 'パスワード（確認のため再入力）', with: "foobar"
        click_on '登録する'

        expect(page).to have_content 'ユーザ登録に成功しました'
        expect(page).to have_content 'Tom Brady'
      }.to change(User, :count).by(1)
    end

    it 'fails with invalid information' do
      visit root_path
      click_on '新規登録'

      expect {
        fill_in 'ユーザー名', with: "Tom Brady"
        fill_in 'メールアドレス', with: "tester@.com"
        fill_in 'パスワード', with: "foobar"
        fill_in 'パスワード（確認のため再入力）', with: "foobar"
        click_on '登録する'

        expect(page).to have_content '1件のエラーがあります'
        expect(page).to have_button '登録する'
      }.to change(User, :count).by(0)
    end
  end
end