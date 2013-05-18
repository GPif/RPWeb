class AddCareerAccess < ActiveRecord::Migration
  def change
    add_column :careers, :access, :string
  end
end
