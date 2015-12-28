class Education < ActiveRecord::Base
  has_and_belongs_to_many :resumes

  def school_text
    return "#{I18n.t 'education'} ##{id}" if school.nil? or school.empty?
    return school
  end

  def degree_text
    return "#{I18n.t 'no_degree'}" if degree.nil? or degree.empty?
    return degree
  end
end
