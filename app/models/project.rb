class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :resumes

  def title_text
    return "#{I18n.t 'project'} ##{id}" if title.nil? or title.empty?
    return title
  end
end
