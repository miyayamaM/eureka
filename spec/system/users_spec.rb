require 'rails_helper'

RSpec.describe 'Users', type: :system do
  
  let!(:user) { FactoryBot.create(:user) }

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

        expect(page).to have_content 'アカウント認証メールを送信しました。受信メールを確認し、アカウントを有効化してください'
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

  describe 'Edit' do

    it 'is successful with valid information', js: true do
      sign_in_as user

      find(".dropdown-toggle").click
      click_on 'ユーザー情報編集'

      fill_in 'ユーザー名', with: "Manning"
      fill_in 'メールアドレス', with: "tester2@example.com"
      click_on '保存する'

      expect(page).to have_content 'ユーザー情報を変更しました'
      visit current_path 
      expect(page).to_not have_content 'ユーザー情報を変更しました'
      expect(page).to have_content "Manning"
    end

    it 'fails with invalid information', js: true  do
      sign_in_as user

      find(".dropdown-toggle").click
      click_on 'ユーザー情報編集'

      fill_in 'ユーザー名', with: ""
      fill_in 'メールアドレス', with: ""
      click_on '保存する'

      expect(page).to have_content '3件のエラーがあります'
    end
  end

  describe 'Index' do
    it "shows pagination", js: true do
      FactoryBot.create_list(:users, 40)
      
      sign_in_as user
      visit users_path 
      
      expect(page).to have_selector('.page-link')
    end

    it "shows only activated users", js: true do
      unactivated_user = FactoryBot.create(:unactivated_user)

      sign_in_as user
      visit users_path

      expect(page).to have_content(user.name)
      expect(page).to_not have_content(unactivated_user.name)
    end
  end

  describe 'Destroy' do
    it "destroys his account", js: true  do
      sign_in_as user

      expect {
        find(".dropdown-toggle").click
        click_on 'ユーザー情報編集'
        click_on '退会する'
      }.to change(User, :count).by(-1)

      expect(page).to have_content '退会しました。ご利用ありがとうございました'
      expect(page).to have_content 'ログイン'
      visit current_path
      expect(page).to_not have_content '退会しました。ご利用ありがとうございました'
    end
  end
 end