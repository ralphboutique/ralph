class CreateUsersWarehousesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :warehouses do |t|
      # t.index [:user_id, :warehouse_id]
      # t.index [:warehouse_id, :user_id]
    end
  end
end
