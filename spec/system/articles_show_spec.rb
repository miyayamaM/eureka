# frozen_string_literal: true

RSpec.describe 'ArticlesShow', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'article show page' do
    it 'displays title and content', js:true do
      sign_in_as user
      post_new_article

      click_on 'Test title'
      expect(page).to have_content 'Test title'
      expect(page).to have_content 'Test content'
    end

    it 'displays related articles' do
      Category.create(id: 1, name: '天文学')
      Category.create(id: 2, name: '遺伝学')
      article = Article.create(title: 'Test title', citation: 'book', content: 'Test content', user_id: user.id, category_id: 1)
      articles_in_same_category = FactoryBot.create_list(:articles, 4, user: user, category_id: 1)
      articles_in_different_category = FactoryBot.create_list(:articles, 4, user: user, category_id: 2)

      visit article_path(article)

      articles_in_same_category.each do |article|
        expect(page).to have_content article.title
      end

      articles_in_different_category.each do |article|
        expect(page).to_not have_content article.title
      end

      expect(find('.related-article')).to_not have_text article.title
    end
  end
end
