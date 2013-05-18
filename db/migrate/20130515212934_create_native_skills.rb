class CreateNativeSkills < ActiveRecord::Migration
  def change
    create_table :native_skills do |t|
      t.integer :requirement_id
      t.integer :choice_ord
      t.integer :competence_id

      t.timestamps
    end
  end
end
