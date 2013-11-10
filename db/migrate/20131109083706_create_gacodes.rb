class CreateGacodes < ActiveRecord::Migration
  def change
    create_table :gacodes do |t|
			t.integer :user_id
			t.string :code
      t.timestamps
    end
		add_index :gacodes, :user_id
  end
end
