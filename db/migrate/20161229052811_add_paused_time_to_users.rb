class AddPausedTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paused_time, :datetime
  end
end
