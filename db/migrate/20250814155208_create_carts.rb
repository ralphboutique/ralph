class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :user, null: true, foreign_key: true # Permitir carritos de invitados
      t.string :session_id, null: false # ID de sesión para invitados
      t.decimal :total, precision: 10, scale: 2, default: 0.0
      t.string :status, default: 'active' # active, completed, abandoned

      t.timestamps
    end
    
    add_index :carts, :session_id
    add_index :carts, [:user_id, :status]
  end
end
