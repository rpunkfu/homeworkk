class ChangeClasses < ActiveRecord::Migration
  def change
  	remove_column :classes, :homework_assigned
  	remove_column :classes, :homework_assignment
  	add_column :classes, :homework_id, :integer
  end
end
