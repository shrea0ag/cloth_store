class AddColToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :name, :string
    add_column :products, :size_xs, :boolean
    add_column :products, :size_s, :boolean
    add_column :products, :size_m, :boolean
    add_column :products, :size_l, :boolean
    add_column :products, :size_xl, :boolean
    add_column :products, :price, :decimal
    add_column :products, :color, :string
  end
end
