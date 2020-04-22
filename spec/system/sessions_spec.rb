require 'rails_helper'

RSpec.describe 'Sessions', type: :system do

  before do 
    @user = FactoryBot.create(:user)
    visit root_path
    click_on 'ログイン'
  end

  describe "Login" do

    it "is successful with valid information", js: true do
      fill_in 'メールアドレス', with: "tester@exmaple.com"
      fill_in 'パスワード', with: "password"
      click_on 'ログインする'

      expect(page).to have_content 'ログインに成功しました'
      visit current_path
      expect(page).to_not have_content 'ログインに成功しました'
      expect(page).to have_content 'Tom'
      expect(page).to_not have_content 'ログイン'
      
      find(".dropdown-toggle").click
      expect(page).to have_content 'ログアウト'
    end

    it "fails with invalid information", js: true  do
      fill_in 'メールアドレス', with: "tester@exmaple.com"
      fill_in 'パスワード', with: ""
      click_on 'ログインする'

      expect(page).to have_content 'ログインに失敗しました。入力情報を確認してください。'
      visit current_path
      expect(page).to_not have_content 'ログインに失敗しました。入力情報を確認してください。'
    end
  end

  describe "Logout" do

    context "when logged in" do
      it "redirects to root", js: true  do
        fill_in 'メールアドレス', with: "tester@exmaple.com"
        fill_in 'パスワード', with: "password"
        click_on 'ログインする'
        
        find(".dropdown-toggle").click
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン'
        expect(page).to have_current_path '/'
      end
    end

    context "when not logged in" do
      
    end
    
    context "when not logged in" do
    end
  end
end