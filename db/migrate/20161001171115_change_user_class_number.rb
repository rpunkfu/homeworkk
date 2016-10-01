class ChangeUserClassNumber < ActiveRecord::Migration
  def change
  	change_column :users, :class_number,  :integer
  end
end
