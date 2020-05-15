# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'search articles' do
    context 'fill in search word' do
      before do
        fishery = FactoryBot.create(:fishery)
        zoology = FactoryBot.create(:zoology)
        environmentology = FactoryBot.create(:environmentology)
        medicine = FactoryBot.create(:medicine)

        @article1 = user.articles.create(title: '日本の水産学の現状', content: '日本は水産大国である', citation: '水産学会誌', category_id: nil, tag_list: nil)
        @article2 = user.articles.create(title: 'サケ類の母川回帰性の種間比較', content: '日本に生息するサケ', citation: '水産学会誌', category_id: fishery.id, tag_list: nil)
        @article3 = user.articles.create(title: '漁と文化の歴史', content: '本研究は水産学的な観点から議論する。', citation: '水産学会誌', category_id: environmentology.id, tag_list: '日本')
        @article4 = user.articles.create(title: '日本の海洋ゴミ問題', content: '海洋ゴミが増加している', citation: '環境学ジャーナル', category_id: nil, tag_list: '水産学')
        @article5 = user.articles.create(title: '魚類生態学', content: 'いろいろな水産物', citation: '水産学会誌', category_id: zoology.id, tag_list: nil)
        @article6 = user.articles.create(title: '魚類生理学', content: '物質が働く', citation: '水産学会誌', category_id: zoology.id, tag_list: nil)

        @article7 = user.articles.create(title: '日本の医療技術', content: '最新の知見', citation: '日本の医学', category_id: medicine.id, tag_list: nil)
        @article8 = user.articles.create(title: 'カタクチイワシの漁獲量変動', content: '水産学的に重要', citation: '水産学会誌', category_id: fishery.id, tag_list: nil)
      end

      it 'finds articles including the word in title or content or category or tags' do
        sign_in_as user

        find('#article-search-form').set('水産学')
        find('#search-button').click

        expect(page).to have_content @article1.title
        expect(page).to have_content @article2.title
        expect(page).to have_content @article3.title
        expect(page).to have_content @article4.title
        expect(page).to_not have_content @article5.title
        expect(page).to_not have_content @article6.title
      end

      it 'finds articles including both words anywhere in title or content or category or tags' do
        sign_in_as user

        find('#article-search-form').set('水産学 日本')
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
