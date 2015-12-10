class AddResponsibilitiesResumesJoinTable < ActiveRecord::Migration
  #def change
  #end
  def self.up
    create_table :responsibilities_resumes, :id => false do |t|
      t.integer :responsibility_id
      t.integer :resume_id
    end
  end

  def self.down
    drop_table :responsibilities_resumes
  end
end
