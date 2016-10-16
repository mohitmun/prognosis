class AddNameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :name, :text
  end
end
