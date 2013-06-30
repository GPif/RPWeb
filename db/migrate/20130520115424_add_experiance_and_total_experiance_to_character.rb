class AddExperianceAndTotalExperianceToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :experience, :integer
    add_column :characters, :total_experience, :integer
  end
end
