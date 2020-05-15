# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bookmarks', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:article) { FactoryBot.create(:article) }

  describe '#Create' do
    context 'logged in' do
      it 'allows for a user to bookmark an article' do
        log_in_as user
        article = user.articles.create(title: 'test', citation: 'book', content: 'content')

        expect do
          post article_bookmarks_path(article.id), xhr: true
        end.to change(Bookmark, :count).by(1)
      end

      it "doesn't allow for a user to duplicated bookmark" do
        log_in_as user
        article = user.articles.create(title: 'test', citation: 'book', content: 'content')

        post article_bookmarks_path(article.id), xhr: true

        expect do
          post article_bookmarks_path(article.id), xhr: true
        end.to change(Bookmark, :count).by(0)
      end
    end

    context 'not logged in' do
      it 'redirects to login_path' do
        expect do
          post article_bookmarks_path(article), xhr: true
        end.to change(Bookmark, :count).by(0)

        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#Destroy' do
    context 'logged in' do
      it 'allows for a user to delete an bookmark' do
        log_in_as user
        article = user.articles.create(title: 'test', citation: 'book', content: 'content')

        post article_bookmarks_path(article.id), xhr: true

        expect do
          delete bookmark_path(article.id), xhr: true
        end.to change(Bookmark, :count).by(-1)
      end
    end

    context 'not logged in' do
      it 'redirects to login_path' do
        bookmark = FactoryBot.create(:bookmark)
        expect do
          delete bookmark_path(bookmark)
        end.to change(Bookmark, :count).by(0)

        expect(response).to redirect_to login_url
      end
    end
  end
end
