require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:article_last_year) { FactoryBot.create(:article_last_year, user: user) }
  let!(:article_last_month) { FactoryBot.create(:article_last_month, user: user) }
  let!(:article_2_days_ago) { FactoryBot.create(:article_2_days_ago, user: user) }
  let!(:article_today) { FactoryBot.create(:article_today, user: user) }
  
  describe "in user's page" do
    
    it "shows articles as expected" do
      FactoryBot.create_list(:articles, 50, user: user)
      sign_in_as user
      
      expect(page).to have_content "#{user.articles.count}"
      expect(page).to have_selector('.page-link')
      user.articles.page(1).per(20).each do |article|
        expect(page).to have_content "#{article.title}"
        expect(page).to have_content "#{article.user.name}"
        expect(page).to have_content "#{article.created_at}"
      end
    end

    it "doesn't display other user's article" do
      other_user.articles.new(title: "other_user's article", content: "other_user's article")
      
      sign_in_as user
      
      expect(page).to_not have_content "other_user's article"
    end

    it "shows most recent article first" do
      sign_in_as user

      expect(first('.articles a')).to have_content "Today"
    end
  end
end