class CreateWerehouses < ActiveRecord::Migration[7.1]
  def change
    create_table :warehouses do |t|
      t.string :title
      t.timestamps
    end
  end
end
