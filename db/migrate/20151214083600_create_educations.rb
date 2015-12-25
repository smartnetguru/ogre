class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :user_id
      t.string :school
      t.date :start
      t.date :end
      t.string :degree

      t.timestamps null: false
    end
  end
end
