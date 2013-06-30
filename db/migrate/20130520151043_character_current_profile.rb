class CharacterCurrentProfile < ActiveRecord::Migration
  def change
    add_column :characters, :ws, :integer
    add_column :characters, :bs, :integer
    add_column :characters, :s, :integer
    add_column :characters, :t, :integer
    add_column :characters, :ag, :integer
    add_column :characters, :int, :integer
    add_column :characters, :wp, :integer
    add_column :characters, :fel, :integer
    add_column :characters, :a, :integer
    add_column :characters, :w, :integer
    add_column :characters, :mag, :integer
    add_column :characters, :m, :integer
    add_column :characters, :ip, :integer
    add_column :characters, :fp, :integer
  end
end
