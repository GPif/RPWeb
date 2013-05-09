class CreateCareerEntries < ActiveRecord::Migration
  def change
    create_table :career_entries do |t|
      t.integer :career_id
      t.integer :next_career_id

      t.timestamps
    end
  end
end
