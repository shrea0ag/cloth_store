class AddNameToBorrowees < ActiveRecord::Migration[5.2]
  def change
    add_column :borrowees, :name, :string
    add_column :borrowees, :phone, :integer
  end
end
