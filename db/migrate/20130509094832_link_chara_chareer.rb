class LinkCharaChareer < ActiveRecord::Migration
  def change
    add_column :characters, :career_id, :integer
    remove_column :characters, :career
  end
end
