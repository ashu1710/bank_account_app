class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.date :transaction_date
      t.integer :amount
      t.string :from_account_num
      t.string :to_account_num
      t.string :transactions_type
      t.string :acc_number
      t.string :ifsc_code
      t.timestamps
    end
  end
end
