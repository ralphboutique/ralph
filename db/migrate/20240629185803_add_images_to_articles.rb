class AddImagesToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :images, :text
  end
end
