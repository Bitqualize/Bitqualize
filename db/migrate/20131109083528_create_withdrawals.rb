class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|

      t.timestamps
    end
  end
end
