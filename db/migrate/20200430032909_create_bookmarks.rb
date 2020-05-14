# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
      t.index %i[user_id article_id], unique: true
    end
  end
end
