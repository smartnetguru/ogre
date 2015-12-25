class EducationJoinTables < ActiveRecord::Migration
  def self.up
    create_table :educations_resumes, :id => false do |t|
      t.integer :education_id
      t.integer :resume_id
    end
  end

  def self.down
    drop_table :educations_resumes
  end
end
