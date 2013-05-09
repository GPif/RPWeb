class AddCharacterDetails < ActiveRecord::Migration
  def change
    add_column :characters, :age, :integer
    add_column :characters, :gender, :string
    add_column :characters, :eye_color, :string
    add_column :characters, :weight, :integer
    add_column :characters, :hair_color, :string
    add_column :characters, :height, :integer
    add_column :characters, :star_sign, :string
    add_column :characters, :number_of_sibling, :string
    add_column :characters, :birthplace, :string
    add_column :characters, :distinguishing_marks, :text
  end
end
