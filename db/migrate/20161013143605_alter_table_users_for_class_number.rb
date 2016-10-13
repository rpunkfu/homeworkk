class AlterTableUsersForClassNumber < ActiveRecord::Migration
  def change
  	ALTER TABLE users ALTER COLUMN class_number TYPE integer USING (class_number::integer);
  end
end
