class AddUniqueIndexToUseAndCategory < ActiveRecord::Migration[5.2]
  def change
  end
  add_index :categories, :name,  unique: true
  add_index :users, :name,  unique: true
end
