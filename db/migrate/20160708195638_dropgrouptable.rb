class Dropgrouptable < ActiveRecord::Migration
  def change
  	drop_table :groups
  end
end
