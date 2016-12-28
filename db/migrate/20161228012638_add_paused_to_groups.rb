class AddPausedToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :paused, :boolean
  end
end
