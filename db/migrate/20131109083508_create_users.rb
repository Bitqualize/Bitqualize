class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
			t.string :email
			t.string :language
			t.string :password_digest
			t.string :activation_token
			t.timestamp :active_since
			t.boolean :is_locked
			t.string :reset_token
      t.timestamps
    end
		add_index :users, :email, :unique => true
		add_index :users, :activation_token
		add_index :users, :reset_token
  end
end
