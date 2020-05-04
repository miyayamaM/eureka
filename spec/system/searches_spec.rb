require 'rails_helper'

RSpec.describe 'Searches', type: :system do

  let(:user) {FactoryBot.create(:user)}

  describe "search articles" do

    
    context "fill in search word" do
      
      before do 
        ["水産学", "遺伝学", "医学", "環境学"].each do |category|
          Category.create(name: category)
        end
  
        @article1 = user.articles.create(title: "日本の水産学の現状", content: "日本は水産大国である", category_id: nil, tag_list: nil)
        @article2 = user.articles.create(title: "サケ類の母川回帰性の種間比較", content: "日本に生息するサケ", category_id: 1, tag_list: nil)
        @article3 = user.articles.create(title: "漁と文化の歴史", content: "本研究は水産学的な観点から議論する。", category_id: 4, tag_list: "日本")
        @article4 = user.articles.create(title: "日本の海洋ゴミ問題", content: "海洋ゴミが増加している", category_id: nil, tag_list: "水産学")
        @article5 = user.articles.create(title: "相対性理論", content: "アインシュタインが草案した", category_id: 3, tag_list: nil)
        @article6 = user.articles.create(title: "相対論", content: "アインシ", category_id: 2, tag_list: nil)
        
        @article7 = user.articles.create(title: "日本の医療技術", content: "最新の知見", category_id: 3, tag_list: nil)
        @article8 = user.articles.create(title: "カタクチイワシの漁獲量変動", content: "水産学的に重要", category_id: 4, tag_list: nil)
      end

      it "finds articles including the word in title or content or category or tags" do
        sign_in_as user
        
        find('#article-search-form').set("水産学")
        find('#search-button').click

        expect(page).to have_content @article1.title
        expect(page).to have_content @article2.title
        expect(page).to have_content @article3.title
        expect(page).to have_content @article4.title
        expect(page).to_not have_content @article6.title
        expect(page).to_not have_content @article7.title

      end

      it "finds articles including both words anywhere in title or content or category or tags" do
        sign_in_as user
          
        find('#article-search-form').set("水産学 日本")
        find('#search-button').click
  
        expect(page).to have_content @article1.title
        expect(page).to have_content @article2.title
        expect(page).to have_content @article3.title
        expect(page).to have_content @article4.title
        expect(page).to_not have_content @article7.title
        expect(page).to_not have_content @article8.title
      end
    end

  end
end