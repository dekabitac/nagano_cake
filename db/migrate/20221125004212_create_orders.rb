class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :billing_amount
      t.integer :shipping_cost
      t.integer :payment_method
      t.integer :order_status
      t.string :postal_code
      t.string :address
      t.string :adressee

      t.timestamps
    end
  end
end
