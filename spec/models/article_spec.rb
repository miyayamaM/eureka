require 'rails_helper'

RSpec.describe Article, type: :model do

  let!(:user){ FactoryBot.create(:user)}
   
  it "is valid" do
    article = FactoryBot.build(:article, user: user)

    expect(article).to be_valid
  end

  describe "without associated user" do
    it "is invalid" do
      article = FactoryBot.build(:article, user_id: nil)
      
      expect(article).to_not be_valid
    end
  end

  describe "without title" do
    it "is invalid" do
      article = FactoryBot.build(:article, user: user, title: nil)
      article.valid?
      
      expect(article.errors[:title]).to include("を入力してください")
    end
  end

  describe "with long (>100) title" do
    it "is invalid" do
      article = FactoryBot.build(:article, user: user, title: "#{"a"*100}")
      expect(article).to be_valid

      article = FactoryBot.build(:article, user: user, title: "#{"a"*101}")
      article.valid?

      expect(article.errors[:title]).to include("は100文字以内で入力してください")
    end
  end

  describe "without content" do
    it "is invalid" do
      article = Article.new(title: "Title", content: nil, user: user)
      article.valid?
      
      expect(article.errors[:content]).to include("を入力してください")
    end
  end

  describe "without citation" do
    it "is invalid" do
      article = Article.new(title: "Title", citation: nil, user: user)
      article.valid?
      
      expect(article.errors[:citation]).to include("を入力してください")
    end
  end

  describe "when user is deleted" do
    it "is deleted together" do
      article = FactoryBot.create(:article, user: user)
      
      expect{user.destroy}.to change(Article, :count).by(-1)
    end
  end
end