class AddColsToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :quantity, :integer
    add_column :order_items, :size, :string
    add_column :order_items, :color, :string
    add_column :order_items, :expected_return_date, :date
  end
end
