class RemoveCountFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :count, :integer
  end
end
