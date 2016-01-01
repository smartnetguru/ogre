class AddRankToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :rank, :integer
  end
end
