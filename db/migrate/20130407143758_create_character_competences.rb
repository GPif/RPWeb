class CreateCharacterCompetences < ActiveRecord::Migration
  def change
    create_table :character_competences do |t|
      t.integer :character_id
      t.integer :competence_id
      t.integer :bonus

      t.timestamps
    end
  end
end
