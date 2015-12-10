class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :skill
  has_and_belongs_to_many :responsibilitys #not sure how to make this railsy
  has_and_belongs_to_many :projects

  def name_text
    return I18n.t('blank') if name.nil? or name.empty?
    return name
  end
  def desc_text
    return I18n.t('blank') if desc.nil? or desc.empty?
    return desc
  end
  def get_relevant_jobs_and_responsibilities
    retval = {}
    responsibilitys.each do |resp|
      retval[resp.job] = [] if (retval[resp.job] == nil)
      retval[resp.job].push(resp)
    end
    retval = retval.sort_by do |job, resp|
      job.start
    end.reverse
    return retval
  end
  def projects_sorted
    projects.sort_by do |project|
      project.start
    end.reverse
  end
  def stylesheet_file
    # This is important for the following reasons
    # - PDF export will want either the file name or the actuall css to load
    # - It makes export to HTML easier work with render layout: false
    # - In the future, there will probably be resume specific CSS files
    ActionController::Base.helpers.asset_path 'resume/default.sass'
  end
end
