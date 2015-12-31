class EducationController < ApplicationController
  before_action :authenticate_user!
  before_action :education_belongs_to_user
  def new
    education = Education.create user_id: current_user.id
    if education.valid?
      redirect_to edit_education_path(education)
    else
      redirect_to :root_path
    end
  end
  def update
    new_education = Hashie::Mash.new(params['education'])
    update_block = {}
    [:school, :start, :end, :degree].each do |f|
      update_block[f] = new_education.send f
    end
    @education.update update_block
    render json: { errors: @education.errors }
  end
  def edit
  end
  def delete
    @education.destroy if not @education.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
  private
  def education_belongs_to_user
    action = params['action'].to_sym
    these_actions = [
      :delete,
      :edit,
      :update
    ]
    @education = Education.where(id: params['id']).first
    if these_actions.include? action
      if @education.user != current_user
        flash[:alert] = I18n.t 'wrong_owner'
        redirect_to '/'
      end
    end
  end
end
