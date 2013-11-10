class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
			t.string :paramname
			t.string :paramvalue
      t.timestamps
    end
		add_index :parameters, :paramname, :unique=>true
  end
end
