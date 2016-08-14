class AddTableGroups < ActiveRecord::Migration
  def change
  	create_table "groups", force: :cascade do |t|
    t.integer "fb_id"
    t.integer "group_num"
    t.string  "group_day"
    t.time    "end_time"
    t.boolean "homework_assigned"
    t.string  "homework_assignment"
  end
  end
end
