class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|

      t.string :addressee
      t.string :postal_code
      t.string :address
      t.integer :customer_id

      t.timestamps
    end
  end
end
