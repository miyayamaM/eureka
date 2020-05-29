# frozen_string_literal: true

module ArticleSupport
  def post_new_article
    click_on '記事を投稿'

    fill_in 'タイトル', with: 'Test title'
    fill_in '引用', with: 'Book'
    fill_in_rich_text_area 'article_content', with: 'Test content'
    click_on '投稿する'
  end
end

RSpec.configure do |config|
  config.include ArticleSupport
end
