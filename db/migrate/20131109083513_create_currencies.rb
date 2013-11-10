class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
			t.string :name
			t.string :long_name
			t.boolean :process_deposits
			t.boolean :allow_withdrawals
			t.boolean :process_orders

			t.decimal :deposit_min_amount
			t.decimal :deposit_max_daily_amount
			t.decimal :withdrawal_max_daily_amount

			t.decimal :fee
			
      t.timestamps
    end
		add_index :currencies, :name, :unique => true
  end
end
