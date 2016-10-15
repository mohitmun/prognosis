class CreateLols < ActiveRecord::Migration
  def change
    create_table :lols do |t|

      t.timestamps
    end
  end
end
