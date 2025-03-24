class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user,    null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer    :quantity,    null: false
      t.decimal    :total_price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
