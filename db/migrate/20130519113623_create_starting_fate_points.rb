class CreateStartingFatePoints < ActiveRecord::Migration
  def change
    create_table :starting_fate_points do |t|
      t.integer :race_id
      t.integer :d1_4
      t.integer :d5_7
      t.integer :d8_10

      t.timestamps
    end
  end
end
