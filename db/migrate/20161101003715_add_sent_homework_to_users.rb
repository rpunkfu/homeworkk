class AddSentHomeworkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sentHomwork, :boolean
  end
end
