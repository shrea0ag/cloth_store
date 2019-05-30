class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.date :actual_return_date
      t.string :status, :default => "processing"
      t.decimal :total
      t.string :address
      t.string :phone
      t.date :expected_return_date
      t.integer :days
      t.references :borrower, foreign_key: true

      t.timestamps
    end
  end
end
