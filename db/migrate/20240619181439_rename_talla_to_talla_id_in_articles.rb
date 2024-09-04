class RenameTallaToTallaIdInArticles < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :talla, :talla_id
  end
end
