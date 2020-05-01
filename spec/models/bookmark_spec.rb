require 'rails_helper'

RSpec.describe Bookmark, type: :model do

  describe "validation" do

    it "is success with valid information" do
      bookmark = FactoryBot.create(:bookmark)
      expect(bookmark).to be_valid
    end

    it "is invalid with empty user" do
      bookmark =  FactoryBot.build(:bookmark, user_id: nil)
      bookmark.valid?
      expect(bookmark.errors[:user_id]).to include "を入力してください"
    end

    it "is invalid with empty article" do
      bookmark =  FactoryBot.build(:bookmark, article_id: nil)
      bookmark.valid?
      expect(bookmark.errors[:article_id]).to include "を入力してください"
    end

  end
  
end
