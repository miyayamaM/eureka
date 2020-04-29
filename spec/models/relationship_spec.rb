require 'rails_helper'

RSpec.describe Relationship, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }

  describe "validation" do
    it "is successful" do
      relationship = Relationship.new(follower_id: user.id, followed_id: other_user.id)
      expect(relationship).to be_valid
    end

    it "is invalid with empty follower_id" do
      relationship = Relationship.new(follower_id: nil, followed_id: other_user.id)
      relationship.valid?
      expect(relationship.errors[:follower_id]).to include "を入力してください"
    end

    it "is invalid with empty followed_id" do
      relationship = Relationship.new(follower_id: user.id, followed_id: nil)
      relationship.valid?
      expect(relationship.errors[:followed_id]).to include "を入力してください"
    end

  end
end
