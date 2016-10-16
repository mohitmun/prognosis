class AddRatingsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :ratings, :json
  end
end
