class CreateArticlesColors < ActiveRecord::Migration[7.1]
  def change
    create_table :articles_colors do |t|
      t.references :article, null: false, foreign_key: true
      t.string :color_hex, null: false
      t.timestamps
    end
  end
end
