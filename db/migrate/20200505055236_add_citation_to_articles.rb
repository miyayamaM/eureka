# frozen_string_literal: true

class AddCitationToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :citation, :string
  end
end
