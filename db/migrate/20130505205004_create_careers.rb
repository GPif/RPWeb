class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :name
      t.text :description
      t.integer :ws
      t.integer :bs
      t.integer :s
      t.integer :t
      t.integer :ag
      t.integer :wp
      t.integer :fel
      t.integer :a
      t.integer :w
      t.integer :mag

      t.timestamps
    end
  end
end
