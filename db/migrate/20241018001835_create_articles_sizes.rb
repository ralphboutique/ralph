class CreateArticlesSizes < ActiveRecord::Migration[7.1]
  def change
    create_table :articles_sizes do |t|
      t.references :article, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.timestamps
    end
  end
end
