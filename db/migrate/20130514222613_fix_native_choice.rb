class FixNativeChoice < ActiveRecord::Migration
  def change 
    add_column :native_choices, :native_choice_competence_id, :integer
    remove_column :native_choices, :competence_id, :integer
  end
end
