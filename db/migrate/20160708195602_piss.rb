class Piss < ActiveRecord::Migration
  def change
  	rename_column :lectures, :class_num, :group_num
  	rename_column :lectures, :class_day, :group_day
  end
end
