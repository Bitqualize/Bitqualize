class CreateTrxhistories < ActiveRecord::Migration
  def change
    create_table :trxhistories do |t|

      t.timestamps
    end
  end
end
