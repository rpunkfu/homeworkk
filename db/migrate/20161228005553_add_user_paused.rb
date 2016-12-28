class AddUserPaused < ActiveRecord::Migration
  def change
  	drop_table :paused_users
  	add_column :users, :paused, :boolean
  end
end
