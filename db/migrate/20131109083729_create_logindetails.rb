class CreateLogindetails < ActiveRecord::Migration
  def change
    create_table :logindetails do |t|

      t.timestamps
    end
  end
end
