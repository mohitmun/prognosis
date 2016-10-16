class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :start_date
      t.text :end_date
      t.text :qualification
      t.text :education
      t.text :skills

      t.timestamps
    end
  end
end
