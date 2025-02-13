class AddQuantityToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :quantity, :integer
  end
end
