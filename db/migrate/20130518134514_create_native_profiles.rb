class CreateNativeProfiles < ActiveRecord::Migration
  def change
    create_table :native_profiles do |t|
      t.integer :race_id
      t.integer :ws
      t.integer :bs
      t.integer :s
      t.integer :t
      t.integer :ag
      t.integer :ag
      t.integer :int
      t.integer :wp
      t.integer :a
      t.integer :m
      t.integer :mag
      t.integer :ip

      t.timestamps
    end
  end
end
