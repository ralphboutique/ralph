class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.text :title
      t.text :description
      t.integer :warehouse_id
      t.integer :category_id
      t.integer :price
      t.text :serial
      t.timestamps
    end
  end
end