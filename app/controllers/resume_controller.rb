class ResumeController < ApplicationController
  before_action :anonymous_preview
  before_action :authenticate_user!
  before_action :resume_belongs_to_user

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
    update_block = {}
    [:name, :desc, :website, :email, :contactname, :phone, :address].each do |f|
      update_block[f] = new_resume.send f
    end
    @resume.update update_block
    render json: { errors: @resume.errors }
  end
  def edit
    @educations = Education.where(user_id: current_user.id)
    @jobs = Job.where(user: current_user)
    @projects = Project.where(user: current_user)
    @skills = @resume.skills_sorted
  end
  def delete
    @resume.destroy if not @resume.nil?
    # not sure why
    # redirect_to :root_path
    # doesn't work here. I really hope it's not part of a
    # bigger problem
    redirect_to '/'
  end
  def update_educations
    params['education'].each do |http_resp|
      education = Education.where(id: http_resp[0].to_i).first
      related = http_resp[1] == '1'
      if related then
        @resume.educations.append(education) if !@resume.educations.include? education
      else
        @resume.educations.delete(education)
      end
    end
    render json: { errors: @resume.errors }
  end
  def update_resps
    params['resp'].each do |http_resp|
      resp = Responsibility.where(id: http_resp[0].to_i).first
      related = http_resp[1] == '1'
      if related then
        @resume.responsibilitys.append(resp) if not @resume.responsibilitys.include? resp
      else
        @resume.responsibilitys.delete(resp)
      end
    end
    render json: { errors: @resume.errors }
  end
  def update_projects
    params['project'].each do |http_resp|
      project = Project.where(id: http_resp[0].to_i).first
      related = http_resp[1] == '1'
      if related then
        @resume.projects.append(project) if not @resume.projects.include? project
      else
        @resume.projects.delete(project)
      end
    end
    render json: { errors: @resume.errors }
  end
  def new_skill
    @skill = Skill.create({resume: @resume})
    redirect_to edit_resume_path @resume
  end
  def export_txt
    @jars = @resume.get_relevant_jobs_and_responsibilities
    @educations = @resume.educations_sorted
    render layout: false, content_type: 'text/plain'
  end
  def export_html
    @jars = @resume.get_relevant_jobs_and_responsibilities
    @educations = @resume.educations_sorted
    @projects = @resume.projects_sorted
    render layout: false, content_type: 'text/html'
  end
  def export_pdf
    @jars = @resume.get_relevant_jobs_and_responsibilities
    @educations = @resume.educations_sorted
    html = render_to_string 'export_html', layout: false, content_type: 'text/html'
    kit = PDFKit.new(html, {
      :page_size => 'Letter',
      :margin_top => '0in',
      :margin_right => '0in',
      :margin_bottom => '0in',
      :margin_left => '0in'
    })
    kit.stylesheets << "./public#{@resume.stylesheet_file}"
    pdf = kit.to_pdf
    send_data pdf, {filename: "#{@resume.name}.pdf", type: 'application/pdf'}
  end
  def export_doc
    @jars = @resume.get_relevant_jobs_and_responsibilities
    @educations = @resume.educations_sorted
    html = render_to_string 'export_html', layout: false, content_type: 'text/html'
    docx = PandocRuby.convert(html, :from => :html, :to => :docx)
    send_data docx, {filename: "#{@resume.name}.docx", type: 'application/msword'}
  end
  def duplicate
    dup_tag = I18n.t 'duplicate_noun'
    resume = @resume.dup
    resume.name = "#{resume.name} (duplicate)" if /\(#{dup_tag}\)$/.match(resume.name).nil?
    resume.save # Doing this so the resume gets an id, hoping for a better solution eventually
    ['education', 'project', 'responsibility'].each do |relation|
      plural = "#{relation}s" # the relationships don't seem to have been pluralized correctly
                              # I didn't think it would matter until now
      @resume.send(plural).each do |relative|
        resume.send(plural).push relative
      end
    end
    @resume.skill.each do |_skill|
      skill = _skill.dup
      skill.resume = resume
      skill.save
    end
    resume.save
    redirect_to edit_resume_path(resume)
  end
  def reset_preview_key
    @resume.reset_preview_key
    flash[:notice] = I18n.t 'share_key_reset'
    redirect_to edit_resume_path(@resume)
  end
  def update_skill_order
    order = JSON.parse(params['order'])
    @resume.skill.each do |skill|
      skill.rank = order.index(skill.id)
      skill.save
    end
    render json: { errors: @resume.errors }
  end

  private
  def anonymous_preview
    action = params['action'].to_sym
    if action == :export_html
      @resume = Resume.where(id: params['id']).first
      @preview_key = params['preview_key']
      export_html if @preview_key == @resume.preview_key
    end
  end
  def resume_belongs_to_user
    action = params['action'].to_sym
    these_actions = [
      :duplicate,
      :export_doc,
      :export_pdf,
      :export_html,
      :export_txt,
      :new_skill,
      :update_projects,
      :update_resps,
      :update_educations,
      :update_skill_order,
      :delete,
      :edit,
      :update,
      :reset_preview_key
    ]
    @resume = Resume.where(id: params['id']).first
    if these_actions.include? action
      if @resume.user != current_user
        flash[:alert] = I18n.t 'wrong_owner'
        redirect_to '/'
      end
    end
  end
end
