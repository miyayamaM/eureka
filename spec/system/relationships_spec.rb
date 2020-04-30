require 'rails_helper'

RSpec.describe 'Relationships', type: :system do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }

  describe "following" do
    it "follows other_user" do
      sign_in_as user

      expect(find_by_id('following')).to have_content "0"
      expect(page).to_not have_css '#follow_form'
      
      visit user_path(other_user)
      
      expect(page).to have_css '#follow_form'
      click_on "フォローする"
      expect(find_by_id('followers')).to have_content "1"

      click_on "フォロー中"
      expect(find_by_id('followers')).to have_content "0"
      
      click_on "フォローする"
      visit user_path(user)
      expect(find_by_id('following')).to have_content "1"      
    end
    
  end

  describe "followers" do
    it "is followed by other_user" do
      sign_in_as user
      expect(find_by_id('followers')).to have_content "0"

      FactoryBot.create(:relationship, follower_id: other_user.id, followed_id: user.id )

      visit user_path(user)
      expect(find_by_id('followers')).to have_content "1"
    end
  
  end
end