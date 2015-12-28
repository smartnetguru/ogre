class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :resumes

  def title_text
    return "#{I18n.t 'project'} ##{id}" if title.nil? or title.empty?
    return title
  end

  def desc_text
    return "#{I18n.t 'no_description'}" if desc.nil? or desc.empty?
    return desc
  end
end
