class ProjectResumeJoinTable < ActiveRecord::Migration
  def self.up
    create_table :projects_resumes, :id => false do |t|
      t.integer :project_id
      t.integer :resume_id
    end
  end

  def self.down
    drop_table :projects_resumes
  end
end
