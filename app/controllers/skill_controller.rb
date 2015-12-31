class SkillController < ApplicationController
  before_action :authenticate_user!
  before_action :skill_belongs_to_user
  def update
    new_skill = Hashie::Mash.new(params['skill'])
    update_block = {}
    [:name].each do |f|
      update_block[f] = new_skill.send f
    end
    @skill.update update_block
    render json: { errors: @skill.errors }
  end
  def delete
    resume = @skill.resume
    @skill.destroy if not @skill.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to edit_resume_path(resume)
  end
  private
  def skill_belongs_to_user
    action = params['action'].to_sym
    these_actions = [
      :delete,
      :edit,
      :update
    ]
    @skill = Skill.where(id: params['id']).first
    if these_actions.include? action
      if @skill.resume.user != current_user
        flash[:alert] = I18n.t 'wrong_owner'
        redirect_to '/'
      end
    end
  end
end
