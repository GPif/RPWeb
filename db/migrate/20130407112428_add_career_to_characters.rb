class AddCareerToCharacters < ActiveRecord::Migration
  def change
	add_column :characters, :base_weapon_skill, :integer
	add_column :characters, :base_balistic_skill, :integer
	add_column :characters, :base_strength, :integer
	add_column :characters, :base_toughness, :integer
	add_column :characters, :base_agility, :integer
	add_column :characters, :base_intelligence, :integer
	add_column :characters, :base_will_power, :integer
	add_column :characters, :base_fellowship, :integer
	add_column :characters, :base_attacks, :integer
	add_column :characters, :base_wounds, :integer
	add_column :characters, :base_mouvement, :integer
	add_column :characters, :base_insanity_points, :integer
	add_column :characters, :base_fate_points, :integer
  end
end
