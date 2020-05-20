# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ArticlesCRUD', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:article_last_year) { FactoryBot.create(:article_last_year, user: user) }
  let!(:article_last_month) { FactoryBot.create(:article_last_month, user: user) }
  let!(:article_2_days_ago) { FactoryBot.create(:article_2_days_ago, user: user) }
  let!(:article_today) { FactoryBot.create(:article_today, user: user) }

  describe "in user's page" do
    it 'shows articles as expected' do
      FactoryBot.create_list(:articles, 50, user: user)
      sign_in_as user

      expect(page).to have_selector('.page-link')
      user.articles.page(1).per(20).each do |article|
        expect(page).to have_content article.title.to_s
        expect(page).to have_content article.user.name.to_s
        expect(page).to have_content article.created_at.strftime('%Y年%m月%d日 %H:%M').to_s
      end
    end

    it "doesn't display other user's article" do
      other_user.articles.new(title: "other_user's article", content: "other_user's article")

      sign_in_as user

      expect(page).to_not have_content "other_user's article"
    end

    it 'shows most recent article first' do
      sign_in_as user

      expect(first('.articles a')).to have_content 'Today'
    end
  end

  describe 'post a new article' do
    it 'saves new article ' do
      sign_in_as user

      click_on '記事を投稿'
      expect do
        fill_in 'タイトル', with: 'Test title'
        fill_in '引用', with: 'Book vol.1'
        fill_in_rich_text_area "article_content", with: 'Test content'
        click_on '投稿する'
      end.to change(Article, :count).by(1)

      expect(page).to have_content 'Test title'
    end

    it "doesn't accept invalid article" do
      sign_in_as user

      click_on '記事を投稿'
      expect do
        fill_in 'タイトル', with: ''
        fill_in '引用', with: ''
        fill_in_rich_text_area "article_content", with: ''
        click_on '投稿する'
      end.to change(Article, :count).by(0)

      expect(page).to have_content '3件のエラーがあります'
      expect(page).to have_content 'Titleを入力してください'
      expect(page).to have_content 'Citationを入力してください'
      expect(page).to have_content 'Contentを入力してください'
      expect(page).to have_current_path '/articles'
    end
  end

  describe 'delete an article' do
    it "deletes user's own article" do
      sign_in_as user
      post_new_article

      
      expect do
        first('.article-delete-btn').click
        expect(page.driver.browser.switch_to.alert.text).to eq "記事を削除しますか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '記事を削除しました'      
      end.to change(Article, :count).by(-1)

      expect(page).to_not have_content 'Test title'
    end
  end

  describe 'edit an article' do
    it 'updates an article' do
      sign_in_as user
      post_new_article

      expect(page).to have_content 'Test title'
      first('.article-update-btn').click
      fill_in 'タイトル', with: 'changed title'
      fill_in '引用', with: 'changed book'
      fill_in_rich_text_area "article_content", with: 'changed content'
      click_on '投稿する'

      expect(page).to_not have_content 'Test title'
      expect(page).to have_content 'changed title'
    end

    it 'renders if invalid article' do
      sign_in_as user
      post_new_article

      expect(page).to have_content 'Test title'
      first('.article-update-btn').click
      fill_in 'タイトル', with: ''
      fill_in '引用', with: ''
      fill_in_rich_text_area "article_content", with: ''
      click_on '投稿する'

      expect(page).to have_content 'Titleを入力してください'
      expect(page).to have_content 'Citationを入力してください'
      expect(page).to have_content 'Contentを入力してください'
      expect(page).to have_css 'form'

      visit user_path(user)
      expect(page).to have_content 'Test title'
    end
  end
end
