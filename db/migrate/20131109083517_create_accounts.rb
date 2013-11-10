class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
			t.integer :user_id
			t.integer :currency_id
			t.decimal :balance
			t.decimal :balance_available
      t.timestamps
    end
		add_index :accounts, [:user_id,:currency_id], :name => "IX_ACCOUNTS_1", :unique => true
  end
end
