class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :sale_date
      t.decimal :sale_amount
      t.integer :consumer_id
      t.integer :merchant_id

      t.timestamps null: false
    end
    add_index :transactions, :consumer_id
    add_index :transactions, :merchant_id
  end
end
