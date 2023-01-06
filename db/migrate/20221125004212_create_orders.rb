class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.integer :billing_amount
      t.integer :shipping_cost
      t.integer :payment_method, default: 0, null: false, limit: 1
      t.integer :order_status, default: 0, null: false, limit: 1
      t.string :postal_code
      t.string :address
      t.string :addressee

      t.timestamps
    end
  end
end
