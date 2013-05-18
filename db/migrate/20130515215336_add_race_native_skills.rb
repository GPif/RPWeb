class AddRaceNativeSkills < ActiveRecord::Migration
  def change 
    add_column :native_skills, :race_id, :integer
  end
end
