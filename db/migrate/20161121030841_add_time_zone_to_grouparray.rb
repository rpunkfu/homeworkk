class AddTimeZoneToGrouparray < ActiveRecord::Migration
  def change
    add_column :grouparray, :time_zone, :integer
  end
end
