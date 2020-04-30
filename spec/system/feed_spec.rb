require 'rails_helper'

RSpec.describe 'Feeds', type: :system do

  describe "show feed(timeline)" do

    let(:user) { FactoryBot.create(:user) }
    let(:follower) { FactoryBot.create(:other_user) }
    let(:following) { FactoryBot.create(:third_user) }

    it "displays expected articles" do
      FactoryBot.create_list(:articles, 10, user: user)
      FactoryBot.create_list(:articles, 10, user: follower)
      FactoryBot.create_list(:articles, 10, user: following)
      Relationship.create(follower_id: user.id, followed_id: following.id)
      Relationship.create(follower_id: follower.id, followed_id: user.id)


      sign_in_as user
      visit root_path

      expect(page).to have_content "タイムライン"

      user.articles.each do |article|
        expect(page).to have_content "#{article.title}"
      end

      following.articles.each do |article|
        expect(page).to have_content "#{article.title}"
      end

      follower.articles.each do |article|
        expect(page).to_not have_content "#{article.title}"
      end
      
    end
  end
end