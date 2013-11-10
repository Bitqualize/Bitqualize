class CreateGausers < ActiveRecord::Migration
  def change
    create_table :gausers do |t|
			t.integer :user_id
      t.timestamps
    end
		add_index :gausers, :user_id
  end
end
