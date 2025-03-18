class AddPaidInstallmentsToSales < ActiveRecord::Migration[7.1]
  def change
    add_column :sales, :paid_installments, :integer
  end
end
