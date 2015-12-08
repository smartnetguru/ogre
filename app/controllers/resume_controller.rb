class ResumeController < ApplicationController
  def new
    resume = Resume.create user_id: current_user.id
    if resume.valid?
      redirect_to edit_resume_path(resume)
    else
      redirect_to :root_path
    end
  end
  def update
    new_resume = Hashie::Mash.new(params['resume'])
    @resume = Resume.where(id: params['id']).first
    update_block = {}
    [:name, :desc, :website, :email, :contactname, :phone, :address].each do |f|
      update_block[f] = new_resume.send f
    end
    @resume.update update_block
    redirect_to edit_resume_path @resume
  end
  def edit
    @resume = Resume.where(id: params['id']).first
  end
  def delete
    resume = Resume.where(id: params['id']).first
    resume.destroy if not resume.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
end
