class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.string :payment_method
      t.date :date
      t.decimal :total_amount

      t.timestamps
    end
  end
end
