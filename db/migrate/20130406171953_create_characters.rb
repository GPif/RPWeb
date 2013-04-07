class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.references :user

      t.timestamps
    end
    add_index :characters, :user_id
  end
end
