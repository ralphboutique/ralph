class AddWerehouseToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :werehouse_id, :integer
  end
end
