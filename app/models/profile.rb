class Profile < ActiveRecord::Base

  store_accessor :ratings, :commitment, :dec_making, :team_work, :cap_to_work_independent

  def self.jwhere(column, value)
    where("(ratings ->> '#{column}') = '?'", value)
  end

  def self.between(column, value1, value2)
    where("(ratings ->> '#{column}')::int BETWEEN '#{value1}' AND #{value2}")
  end
end
