class AddTimeZoneToGrouparray < ActiveRecord::Migration
  def change
    add_column :grouparrays, :time_zone, :integer
  end
end
