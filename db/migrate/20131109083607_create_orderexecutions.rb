class CreateOrderexecutions < ActiveRecord::Migration
  def change
    create_table :orderexecutions do |t|

      t.timestamps
    end
  end
end
