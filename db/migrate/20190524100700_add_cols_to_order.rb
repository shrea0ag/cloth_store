class AddColsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :status, :string, :default => "processing"
    add_column :orders, :address, :string
    add_column :orders, :phone, :integer
    add_column :orders, :total, :decimal
  end
end
