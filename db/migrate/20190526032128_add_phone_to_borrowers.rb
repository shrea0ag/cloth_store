class AddPhoneToBorrowers < ActiveRecord::Migration[5.2]
  def change
    add_column :borrowers, :name, :string
    add_column :borrowers, :phone, :integer
  end
end
