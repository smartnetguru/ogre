class ResponsibilityController < ApplicationController
  def update
    resp = Responsibility.where(id: params['id']).first
    resp.text = params['responsibility']['text']
    resp.save
    render json: { errors: resp.errors }
  end
  def delete
    resp = Responsibility.where(id: params['id']).first
    job = resp.job
    resp.destroy if not resp.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to edit_job_path(job)
  end
end
