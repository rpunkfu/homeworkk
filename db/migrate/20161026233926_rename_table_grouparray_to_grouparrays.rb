class RenameTableGrouparrayToGrouparrays < ActiveRecord::Migration
  def change
  	rename_table :grouparray, :grouparrays
  end
end
