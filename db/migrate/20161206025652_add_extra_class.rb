class AddExtraClass < ActiveRecord::Migration
  def change
    add_column :groups, :extra_class, :boolean
    add_column :grouparrays, :extra_class, :boolean
  end
end
