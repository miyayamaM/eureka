require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with a name, email and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe "name" do
    
    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a long (> 40) name" do
      user = FactoryBot.build(:user, name: "#{"a"*40}")
      expect(user).to be_valid

      user = FactoryBot.build(:user, name: "#{"a"*41}")
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    it "is invalid with duplicated name" do
      FactoryBot.create(:user, name:"Manning")
      user = FactoryBot.build(:user, name:"Manning")

      user.valid?
      expect(user.errors[:name]).to include("has already been taken")
    end

  end

  describe "email" do

    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid with a long (> 255) email" do
      user = FactoryBot.build(:user, email: "#{"a"*255}@example.com")
      user.valid?
      expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
    end

    it "is invalid with duplicated email" do
      FactoryBot.create(:user, email: "test@example.com")
      user = FactoryBot.build(:user, email: "test@example.com")

      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is invalid with a wrong email address" do
      wrong_emails = ["foo@exmaple,com", "foo.com", "foo@examplecom"]

      wrong_emails.each do | wrong_email |
        user = FactoryBot.build(:user, email: wrong_email)
        user.valid?
        expect(user.errors[:email]).to include ("is invalid")
      end
    end
  end

  describe "password" do

    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a short (< 6) password" do
      user = FactoryBot.build(:user, password: "aaa")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
    
  end

  describe "authenticated? method" do
    it "returns false with nil digest" do
      user = FactoryBot.create(:user)
      expect(user.authenticated?("")).to be_falsey
    end
  end
end
