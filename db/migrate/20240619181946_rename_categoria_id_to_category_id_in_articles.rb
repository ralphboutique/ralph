class RenameCategoriaIdToCategoryIdInArticles < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :categoria_id, :category_id
  end
end
