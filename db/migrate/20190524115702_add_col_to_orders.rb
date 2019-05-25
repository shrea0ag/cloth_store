class AddColToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :actual_return_date, :date
  end
end
