class AddCategoriaIdToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :categoria_id, :string
  end
end
