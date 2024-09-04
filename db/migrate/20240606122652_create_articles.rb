class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :color
      t.text :talla
      t.text :desciption
      t.timestamps
    end
  end
end
