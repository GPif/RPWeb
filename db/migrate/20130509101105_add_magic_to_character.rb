class AddMagicToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :base_magic, :integer
  end
end
