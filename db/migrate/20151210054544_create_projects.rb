class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :title
      t.string :desc
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
