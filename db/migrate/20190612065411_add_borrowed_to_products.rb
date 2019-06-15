class AddBorrowedToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :borrowed_quantity, :integer, :default => 0
  end
end
