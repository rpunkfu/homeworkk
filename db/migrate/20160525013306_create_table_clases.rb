class CreateTableClases < ActiveRecord::Migration
  def change
    create_table :classes do |t|
    	t.integer :fb_id
    	t.integer :class_num
    	t.string :class_day
    	t.time :end_time
    	t.boolean :homework_assigned
    	t.string :homework_assignment, :null => true
    end
  end
end
