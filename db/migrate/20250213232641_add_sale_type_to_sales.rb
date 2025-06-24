class AddSaleTypeToSales < ActiveRecord::Migration[7.1]
  def change
    add_column :sales, :sale_type, :string, default: 'direct'
  end
end
