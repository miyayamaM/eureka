class ApplicationController < ActionController::Base
  before_action :set_search_word
  include SessionsHelper

  def set_search_word
    @search_words = Article.ransack(params[:q])

    if params[:q] != nil
      @key_words = params[:q][:title_or_content_or_category_name_or_tags_name_cont].split(/[\p{blank}\s]+/)
      word_array = @key_words.inject([]) {|array, word| array.push({ title_or_content_or_category_name_or_tags_name_cont: word })}
      @hit_articles = Article.ransack(combinator: 'and', groupings: word_array).result
    else
      @hit_articles = @search_words.result
    end
  end

  private
    def login_required
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
