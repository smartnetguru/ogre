class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :company
      t.string :position
      t.string :location
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
