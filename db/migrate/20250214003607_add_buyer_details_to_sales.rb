class AddBuyerDetailsToSales < ActiveRecord::Migration[7.1]
  def change
    add_column :sales, :name, :string
    add_column :sales, :lastname, :string
    add_column :sales, :id_number, :string
    add_column :sales, :phone, :string
  end
end
