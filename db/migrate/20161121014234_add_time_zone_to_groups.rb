class AddTimeZoneToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :time_zone, :integer
  end
end
