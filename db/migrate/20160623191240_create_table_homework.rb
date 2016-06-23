class CreateTableHomework < ActiveRecord::Migration
  def change
    create_table :homework do |t|
      t.integer :homework_id
      t.string :assignment
    end
  end
end
