class EducationController < ApplicationController
  before_action :authenticate_user!
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
    @education = Education.where(id: params['id']).first
    update_block = {}
    [:school, :start, :end, :degree].each do |f|
      update_block[f] = new_education.send f
    end
    @education.update update_block
    redirect_to edit_education_path(@education)
  end
  def edit
    @education = Education.where(id: params['id']).first
  end
  def delete
    education = Education.where(id: params['id']).first
    education.destroy if not education.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
end
