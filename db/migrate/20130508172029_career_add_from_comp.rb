class CareerAddFromComp < ActiveRecord::Migration
  def change
    add_column :careers, :skills_desc, :text
    add_column :careers, :talents_desc, :text
    add_column :careers, :trappings_desc, :text
    add_column :careers, :entry_desc, :text
    add_column :careers, :exit_desc, :text
  end
end
