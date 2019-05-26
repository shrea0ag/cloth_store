class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.string :size
      t.string :color
      t.date :expected_return_date
      t.references :borrower, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
