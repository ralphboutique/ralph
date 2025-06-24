class AddInstallmentsToSales < ActiveRecord::Migration[7.1]
  def change
    add_column :sales, :installments, :integer
  end
end
