class CreateCharacterTalent < ActiveRecord::Migration
  def change  
    create_table :characters_talents, :id => false do |t|
      t.references :character, :null => false
      t.references :talent, :null => false
    end
  end
end
