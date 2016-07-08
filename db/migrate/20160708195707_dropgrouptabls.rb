class Dropgrouptabls < ActiveRecord::Migration
  def change
  	rename_table :lectures, :groups
  end
end
