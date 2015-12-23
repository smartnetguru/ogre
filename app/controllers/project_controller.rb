class ProjectController < ApplicationController
  before_action :authenticate_user!
  def new
    project = Project.create user: current_user
    if project.valid?
      redirect_to edit_project_path(project)
    else
      redirect_to :root_path
    end
  end
  def update
    new_project = Hashie::Mash.new(params['project'])
    @project = Project.where(id: params['id']).first
    update_block = {}
    [:title, :desc, :start, :end].each do |f|
      update_block[f] = new_project.send f
    end
    @project.update update_block
    redirect_to edit_project_path @project
  end
  def edit
    @project = Project.where(id: params['id']).first
  end
  def delete
    project = Project.where(id: params['id']).first
    project.destroy if not project.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
end
