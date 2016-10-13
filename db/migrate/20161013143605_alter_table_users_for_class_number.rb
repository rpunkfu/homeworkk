class AlterTableUsersForClassNumber < ActiveRecord::Migration
  def change
  	change_column :users, :class_number,  :string
  end
end
