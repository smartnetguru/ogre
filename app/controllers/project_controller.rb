class ProjectController < ApplicationController
  before_action :authenticate_user!
  before_action :project_belongs_to_user
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
    update_block = {}
    [:title, :desc, :start, :end].each do |f|
      update_block[f] = new_project.send f
    end
    @project.update update_block
    render json: { errors: @project.errors }
  end
  def edit
  end
  def delete
    @project.destroy if not @project.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
  private
  def project_belongs_to_user
    action = params['action'].to_sym
    these_actions = [
      :delete,
      :edit,
      :update
    ]
    @project = Project.where(id: params['id']).first
    if these_actions.include? action
      if @project.user != current_user
        flash[:alert] = I18n.t 'wrong_owner'
        redirect_to '/'
      end
    end
  end
end
