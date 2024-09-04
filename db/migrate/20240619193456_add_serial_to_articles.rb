class AddSerialToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :serial, :text
  end
end
