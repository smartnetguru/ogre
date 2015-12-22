class JobController < ApplicationController
  before_action :authenticate_user!
  def new
    job = Job.create user_id: current_user.id
    if job.valid?
      redirect_to edit_job_path(job)
    else
      redirect_to :root_path
    end
  end
  def update
    new_job = Hashie::Mash.new(params['job'])
    @job = Job.where(id: params['id']).first
    update_block = {}
    [:company, :position, :location, :start, :end].each do |f|
      update_block[f] = new_job.send f
    end
    @job.update update_block
    redirect_to edit_job_path @job
  end
  def edit
    @job = Job.where(id: params['id']).first
  end
  def delete
    job = Job.where(id: params['id']).first
    job.responsibility.destroy_all
    job.destroy if not job.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
  def new_resp
    @job = Job.where(id: params['id']).first
    Responsibility.create(job: @job)
    redirect_to edit_job_path @job
  end
end
