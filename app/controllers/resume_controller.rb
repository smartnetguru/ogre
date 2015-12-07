class ResumeController < ApplicationController
  def new
    resume = Resume.create user_id: current_user.id
    if resume.valid?
      redirect_to "/resume/#{resume.id}/edit"
    else
      redirect_to :root_path
    end
  end
  def edit
    @resume = Resume.where(id: params['id']).first
  end
  def delete
    resume = Resume.where(id: params['id']).first
    resume.destroy if not resume.nil?
    redirect_to '/'
  end
end
