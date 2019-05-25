class AddCountToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :count, :integer, :default => 4
  end
end
