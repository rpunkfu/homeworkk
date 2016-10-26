class CreateTableGroupArray < ActiveRecord::Migration
  def change
    create_table :grouparray do |t|
    t.integer "fb_id"
    t.integer "group_num"
    t.string  "group_day"
    t.time    "end_time"
    t.boolean "homework_assigned"
    t.string  "homework_assignment"
    t.string  "conversation_id"
    t.string  "group_name"
    t.integer "user_id"
    end
  end
end
