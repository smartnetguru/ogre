class AddPreviewToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :preview_key, :string
  end
end
