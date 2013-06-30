class CreateStartingWounds < ActiveRecord::Migration
  def change
    create_table :starting_wounds do |t|
      t.integer :race_id
      t.integer :d1_3
      t.integer :d4_6
      t.integer :d7_9
      t.integer :d10

      t.timestamps
    end
  end
end
