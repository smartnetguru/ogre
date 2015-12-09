class CreateResponsibilities < ActiveRecord::Migration
  def change
    create_table :responsibilities do |t|
      t.integer :job_id
      t.string :text

      t.timestamps null: false
    end
  end
end
