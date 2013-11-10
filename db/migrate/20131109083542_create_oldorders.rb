class CreateOldorders < ActiveRecord::Migration
  def change
    create_table :oldorders do |t|

      t.timestamps
    end
  end
end
