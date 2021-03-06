class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_num
      t.string :name
      t.integer :month
      t.integer :year
      t.integer :cvv
      t.integer :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
