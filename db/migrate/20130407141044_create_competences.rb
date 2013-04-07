class CreateCompetences < ActiveRecord::Migration
  def change
    create_table :competences do |t|
      t.string :name
      t.string :characteristic
      t.boolean :base
      t.text :description

      t.timestamps
    end
  end
end
