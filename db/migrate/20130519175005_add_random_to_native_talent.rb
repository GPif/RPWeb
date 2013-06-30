class AddRandomToNativeTalent < ActiveRecord::Migration
  def change
    add_column :native_talents, :random, :boolean
  end
end
