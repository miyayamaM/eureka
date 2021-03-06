# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:article) { FactoryBot.create(:article, user_id: other_user.id) }

  it 'is valid with a name, email and password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe 'name' do
    it 'is invalid without a name' do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'is invalid with a long (> 40) name' do
      user = FactoryBot.build(:user, name: ('a' * 40).to_s)
      expect(user).to be_valid

      user = FactoryBot.build(:user, name: ('a' * 41).to_s)
      user.valid?
      expect(user.errors[:name]).to include('は40文字以内で入力してください')
    end

    it 'is invalid with duplicated name' do
      FactoryBot.create(:user, name: 'Manning')
      user = FactoryBot.build(:user, name: 'Manning')

      user.valid?
      expect(user.errors[:name]).to include('はすでに存在します')
    end
  end

  describe 'email' do
    it 'is invalid without an email' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'is invalid with a long (> 255) email' do
      user = FactoryBot.build(:user, email: "#{'a' * 255}@example.com")
      user.valid?
      expect(user.errors[:email]).to include('は255文字以内で入力してください')
    end

    it 'is invalid with duplicated email' do
      FactoryBot.create(:user, email: 'test@example.com')
      user = FactoryBot.build(:user, email: 'test@example.com')

      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it 'is invalid with a wrong email address' do
      wrong_emails = ['foo@exmaple,com', 'foo.com', 'foo@examplecom']

      wrong_emails.each do |wrong_email|
        user = FactoryBot.build(:user, email: wrong_email)
        user.valid?
        expect(user.errors[:email]).to include 'は不正な値です'
      end
    end
  end

  describe 'password' do
    it 'is invalid without a password' do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'is invalid with a short (< 6) password' do
      user = FactoryBot.build(:user, password: 'aaa')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end
  end

  describe 'authenticated? method' do
    it 'returns false with nil digest' do
      user = FactoryBot.create(:user)
      expect(user.authenticated?(:remember, '')).to be_falsey
    end
  end

  describe 'follow/unfollow method' do
    it 'manipulates following' do
      user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:other_user)

      expect(user.following?(other_user)).to be_falsey

      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy

      user.unfollow(other_user)
      expect(user.following?(other_user)).to be_falsey
    end
  end

  describe 'followers method' do
    it 'returns followers' do
      user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:other_user)

      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      expect(other_user.followers).to include user
    end
  end

  describe 'feed' do
    it "includes own or follower's articles" do
      user_article = FactoryBot.create(:article, user: user)
      follower_article = FactoryBot.create(:article, user: other_user)

      user.follow(other_user)
      expect(user.feed).to include user_article
      expect(user.feed).to include follower_article
    end

    it "doesn't include articles of unfollowers" do
      user_article = FactoryBot.create(:article, user: user)
      unfollower_article = FactoryBot.create(:article, user: other_user)

      expect(user.feed).to include user_article
      expect(user.feed).to_not include unfollower_article
    end
  end

  describe 'bookmark method' do
    it 'bookmarks an article' do
      user.bookmark(article)
      expect(user.bookmark_articles).to include article
    end
  end

  describe 'unbookmark method' do
    it 'deletes a bookmark' do
      user.bookmark(article)
      expect(user.bookmark_articles).to include article

      user.unbookmark(article)
      expect(user.bookmark_articles).to_not include article
    end
  end
end
