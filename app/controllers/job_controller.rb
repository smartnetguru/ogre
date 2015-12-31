class JobController < ApplicationController
  before_action :authenticate_user!
  before_action :job_belongs_to_user

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
    update_block = {}
    [:company, :position, :location, :start, :end].each do |f|
      update_block[f] = new_job.send f
    end
    @job.update update_block
    render json: { errors: @job.errors }
  end
  def edit
  end
  def delete
    @job.responsibility.destroy_all
    @job.destroy if not job.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
  def new_resp
    Responsibility.create(job: @job)
    redirect_to edit_job_path @job
  end

  private
  def job_belongs_to_user
    action = params['action'].to_sym
    these_actions = [
      :new_resp,
      :delete,
      :edit,
      :update
    ]
    @job = Job.where(id: params['id']).first
    if these_actions.include? action
      if @job.user != current_user
        flash[:alert] = I18n.t 'wrong_owner'
        redirect_to '/'
      end
    end
  end

end
