require 'rails_helper'

RSpec.describe 'Categories', type: :system do

  let(:user) { FactoryBot.create(:user) }
  let(:article) { FactoryBot.create(:article, user: user) }
  
  before do
    categories = %w[遺伝学 天文学 医学 水産学 動物学]
    categories.each {|category| Category.create(name: category)}
  end

  describe "select box" do
    it "shows all categories" do
      sign_in_as user

      click_on "記事を投稿"
      expect(page).to have_select("カテゴリー", options: %w!選択してください 遺伝学 天文学 医学 水産学 動物学! )

      visit edit_article_path(article)
      expect(page).to have_select("カテゴリー", options: %w!選択してください 遺伝学 天文学 医学 水産学 動物学! )
    end

  end

  describe "user posts an article" do

    context "without picture and category" do

      it "shows default picture" do
        sign_in_as user

        click_on "記事を投稿"
        expect {
          fill_in 'タイトル', with: "Test title"
          fill_in '内容', with: "Test content"
          select "選択してください", from: "カテゴリー"
          click_on '投稿する'
        }.to change(Article, :count).by(1)
        
        expect(page).to have_css "#default-picture"
        expect(page).to_not have_css "#category-picture"
        expect(page).to_not have_css "#attached-picture"
      end

    end

    context "without picture and  with category" do

      it "shows category picture" do
        sign_in_as user

        click_on "記事を投稿"
        expect {
          fill_in 'タイトル', with: "Test title"
          fill_in '内容', with: "Test content"
          select "遺伝学", from: "カテゴリー"
          click_on '投稿する'
        }.to change(Article, :count).by(1)
        
        expect(page).to have_css "#category-picture"
        expect(page).to_not have_css "#default-picture"
        expect(page).to_not have_css "#attached-picture"
      end

    end

    context "with both picture and category" do

      it "shows attatched picture" do
        sign_in_as user

        click_on "記事を投稿"
        expect {
          fill_in 'タイトル', with: "Test title"
          fill_in '内容', with: "Test content"
          attach_file 'サムネイル画像', "#{Rails.root}/spec/factories/thumbnail.png"
          click_on '投稿する'
        }.to change(Article, :count).by(1)
        
        expect(page).to have_css "#attached-picture"
        expect(page).to_not have_css "#category-picture"
        expect(page).to_not have_css "#default-picture"
      end

    end

    context "with picture and without category" do

      it "shows attatched picture" do
        sign_in_as user

        click_on "記事を投稿"
        expect {
          fill_in 'タイトル', with: "Test title"
          fill_in '内容', with: "Test content"
          attach_file 'サムネイル画像', "#{Rails.root}/spec/factories/thumbnail.png"
          select "遺伝学", from: "カテゴリー"
          click_on '投稿する'
        }.to change(Article, :count).by(1)
        
        expect(page).to have_css "#attached-picture"
        expect(page).to_not have_css "#category-picture"
        expect(page).to_not have_css "#default-picture"
      end

    end

  end
end