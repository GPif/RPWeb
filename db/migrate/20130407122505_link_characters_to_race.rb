class LinkCharactersToRace < ActiveRecord::Migration
  def change
	add_column :characters, :race_id, :integer
	remove_column :characters, :race
  end
end
