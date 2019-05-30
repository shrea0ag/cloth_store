class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :size
      t.string :color
      t.integer :quantity
      t.decimal :total
      t.references :borrower, foreign_key: true
      t.references :product, foreign_key: true
      t.references :order,   foreign_key:true

      t.timestamps
    end
  end
end
