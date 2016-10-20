class Changenametostuff < ActiveRecord::Migration
  def change
  	rename_column :groups, :name, :group_name
  end
end
