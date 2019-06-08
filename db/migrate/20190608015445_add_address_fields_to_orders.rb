class AddAddressFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pincode, :integer
    add_column :orders, :city, :string
  end
end
