class AddStatusToSales < ActiveRecord::Migration[7.1]
  def change
    add_column :sales, :status, :string
  end
end
