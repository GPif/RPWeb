class AddStatusToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :status, :integer
  end
end
