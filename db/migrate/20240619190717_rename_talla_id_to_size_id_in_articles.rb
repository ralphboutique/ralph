class RenameTallaIdToSizeIdInArticles < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :talla_id, :size_id
  end
end
