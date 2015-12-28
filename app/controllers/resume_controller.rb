class ResumeController < ApplicationController
  before_action :authenticate_user!
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
    @educations = Education.where(user_id: current_user.id)
    @jobs = Job.where(user: current_user)
    @projects = Project.where(user: current_user)
    @skills = Skill.where(resume: @resume)
    @educations = @resume.educations
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
  def update_educations
    @resume = Resume.where(id: params['id']).first
    params['education'].each do |http_resp|
      education = Education.where(id: http_resp[0].to_i).first
      related = http_resp[1] == '1'
      if related then
        @resume.educations.append(education) if @resume.educations.include? education
      else
        @resume.educations.delete(education)
      end
    end
    redirect_to edit_resume_path @resume
  end
  def update_resps
    @resume = Resume.where(id: params['id']).first
    params['resp'].each do |http_resp|
      resp = Responsibility.where(id: http_resp[0].to_i).first
      related = http_resp[1] == '1'
      if related then
        @resume.responsibilitys.append(resp) if not @resume.responsibilitys.include? resp
      else
        @resume.responsibilitys.delete(resp)
      end
    end
    redirect_to edit_resume_path @resume
  end
  def update_projects
    @resume = Resume.where(id: params['id']).first
    params['project'].each do |http_resp|
      project = Project.where(id: http_resp[0].to_i).first
      related = http_resp[1] == '1'
      if related then
        @resume.projects.append(project) if not @resume.projects.include? project
      else
        @resume.projects.delete(project)
      end
    end
    redirect_to edit_resume_path @resume
  end
  def new_skill
    @resume = Resume.where(id: params['id']).first
    @skill = Skill.create({resume: @resume})
    redirect_to edit_resume_path @resume
  end
  def export_txt
    @resume = Resume.where(id: params['id']).first
    @jars = @resume.get_relevant_jobs_and_responsibilities
    @educations = @resume.educations_sorted
    render layout: false, content_type: 'text/plain'
  end
  def export_html
    @resume = Resume.where(id: params['id']).first
    @jars = @resume.get_relevant_jobs_and_responsibilities
    @educations = @resume.educations_sorted
    @projects = @resume.projects_sorted
    render layout: false, content_type: 'text/html'
  end
  def export_pdf
    @resume = Resume.where(id: params['id']).first
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
    @resume = Resume.where(id: params['id']).first
    @jars = @resume.get_relevant_jobs_and_responsibilities
    @educations = @resume.educations_sorted
    html = render_to_string 'export_html', layout: false, content_type: 'text/html'
    docx = PandocRuby.convert(html, :from => :html, :to => :docx)
    send_data docx, {filename: "#{@resume.name}.docx", type: 'application/msword'}
  end
end
