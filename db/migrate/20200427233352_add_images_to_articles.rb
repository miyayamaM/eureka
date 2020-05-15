# frozen_string_literal: true

class AddImagesToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :thumbnail, :string
  end
end
