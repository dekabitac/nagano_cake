class CreateOrderDetailes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_detailes do |t|

      t.integer :order_id
      t.integer :item_id
      t.integer :amount
      t.integer :price
      t.integer :making_status, default: 0, null: false, limit: 1

      t.timestamps
    end
  end
end
