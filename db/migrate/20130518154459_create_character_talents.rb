class CreateCharacterTalents < ActiveRecord::Migration
  def change
    create_table :character_talents do |t|
      t.integer :character_id
      t.integer :talent_id

      t.timestamps
    end
  end
end
