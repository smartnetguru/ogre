class SkillController < ApplicationController
  before_action :authenticate_user!
  def update
    new_skill = Hashie::Mash.new(params['skill'])
    @skill = Skill.where(id: params['id']).first
    update_block = {}
    [:name].each do |f|
      update_block[f] = new_skill.send f
    end
    @skill.update update_block
    redirect_to edit_resume_path(@skill.resume)
  end
  def edit
    @job = Job.where(id: params['id']).first
  end
  def delete
    skill = Skill.where(id: params['id']).first
    resume = skill.resume
    skill.destroy if not skill.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to edit_resume_path(resume)
  end
end
