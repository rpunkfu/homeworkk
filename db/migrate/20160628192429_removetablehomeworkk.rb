class Removetablehomeworkk < ActiveRecord::Migration
  def change
  	drop_table :homework
  	remove_column :classes, :homework_id
  	add_column :classes, :homework_assigned, :boolean
  	add_column :classes, :homework_assignment, :string
  end
end
