class CarrerProfile2 < ActiveRecord::Migration
  def change
    add_column :careers, :int, :integer
    add_column :careers, :sb, :integer
    add_column :careers, :tb, :integer
    add_column :careers, :m, :integer
    add_column :careers, :ip, :integer
    add_column :careers, :fp, :integer
  end
end
