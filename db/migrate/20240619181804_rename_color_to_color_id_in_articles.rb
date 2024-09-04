class RenameColorToColorIdInArticles < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :color, :color_id
  end
end
