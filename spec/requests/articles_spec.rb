# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }
  let!(:article) { FactoryBot.create(:article, user: user) }

  describe '#create' do
    context 'logged in' do
      it 'creates new article' do
        log_in_as user

        get new_article_path
        expect do
          post articles_path, params: { article: { title: 'Title',
                                                   citation: 'Book',
                                                   content: 'Content' } }
        end.to change(Article, :count).by(1)

        expect(response).to redirect_to user_path(user)
      end
    end

    context 'not logged in' do
      it 'redirects to login page' do
        get new_article_path
        expect do
          post articles_path, params: { article: { title: 'Title',
                                                   citation: 'Book',
                                                   content: 'Content' } }
        end.to change(Article, :count).by(0)

        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#destroy' do
    context 'logged in' do
      it 'deletes a article' do
        log_in_as user

        expect do
          delete article_path(article)
        end.to change(Article, :count).by(-1)
      end

      it "doesn't allow to delete other_user's articles" do
        log_in_as user
        other_article = FactoryBot.create(:article, user: other_user)

        expect do
          delete article_path(other_article)
        end.to change(Article, :count).by(0)

        expect(response).to redirect_to root_url
      end
    end

    context 'not logged in' do
      it 'redirects to login page' do
        expect do
          delete article_path(article)
        end.to change(Article, :count).by(0)

        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#edit' do
    context 'logged in' do
      it 'updates a article' do
      end

      it "doesn't allow to update other_user's articles" do
      end
    end

    context 'not logged in' do
      it 'redirects to login page' do
        # expect(response).to redirect_to login_url
      end
    end
  end
end
