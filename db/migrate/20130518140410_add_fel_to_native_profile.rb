class AddFelToNativeProfile < ActiveRecord::Migration
  def change
    add_column :native_profiles, :fel, :integer
  end
end
