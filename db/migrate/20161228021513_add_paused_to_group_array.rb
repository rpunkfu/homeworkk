class AddPausedToGroupArray < ActiveRecord::Migration
  def change
    add_column :grouparrays, :paused, :boolean
  end
end
