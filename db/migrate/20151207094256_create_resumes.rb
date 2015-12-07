class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.integer :user_id
      t.string :name
      t.string :desc
      t.string :website
      t.string :email
      t.string :contactname
      t.string :phone
      t.string :address

      t.timestamps null: false
    end
  end
end
