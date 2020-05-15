# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  describe 'top page' do
    it 'shows most bookmarked articles' do
      user = FactoryBot.create(:user)
      users = FactoryBot.create_list(:users, 20)
      articles = FactoryBot.create_list(:articles, 20, user: user)

      users.each do |user|
        articles.last(6).each do |article|
          Bookmark.create(user_id: user.id, article_id: article.id)
        end
      end

      visit root_path

      articles.last(6).each do |article|
        expect(page).to have_content article.title.to_s
      end

      articles.first(14).each do |article|
        expect(page).to_not have_content article.title.to_s
      end
    end
  end
end
