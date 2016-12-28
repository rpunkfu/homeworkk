class CreateTablePausedUsers < ActiveRecord::Migration
  def change
    create_table :paused_users do |t|
	    t.string   "encrypted_password",     default: "", null: false
	    t.string   "reset_password_token"
	    t.datetime "reset_password_sent_at"
	    t.datetime "remember_created_at"
	    t.integer  "sign_in_count",          default: 0,  null: false
	    t.datetime "current_sign_in_at"
	    t.datetime "last_sign_in_at"
	    t.string   "current_sign_in_ip"
	    t.string   "last_sign_in_ip"
	    t.datetime "created_at",                          null: false
	    t.datetime "updated_at",                          null: false
	    t.string   "first_name"
	    t.string   "provider"
	    t.string   "uid"
	    t.string   "class_number"
	    t.string   "conversation_id"
	    t.boolean  "sentHomwork"
	    t.integer  "time_zone"
	    t.string   "email"
    end
  end
end
