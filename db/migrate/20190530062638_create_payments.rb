class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :token
      t.string :transaction_id
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
