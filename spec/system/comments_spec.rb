# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:article) { FactoryBot.create(:article, user_id: user.id) }

  describe 'post a comment' do
    it 'shows the comment' do
      sign_in_as user
      visit article_path(article)

      expect do
        find('#comment-textarea').set('面白い記事ですね')
        click_on 'コメントする'
        expect(page).to have_content '面白い記事ですね'
      end.to change(Comment, :count).by(1)
    end
  end

  describe 'check an article' do
    it 'shows all comments with expected order' do
      FactoryBot.create_list(:comments, 10, user: other_user, article: article)
      sign_in_as user

      all(:css, '.comment-item').each_with_index do |comment, n|
        expect(comment.text).to eq "Very good#{n}"
      end
    end
  end
end
