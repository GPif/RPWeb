class CreateNativeTalents < ActiveRecord::Migration
  def change
    create_table :native_talents do |t|
      t.integer :race_id
      t.integer :choice_ord
      t.integer :requirement_id
      t.integer :talent_id

      t.timestamps
    end
  end
end
