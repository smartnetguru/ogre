class Job < ActiveRecord::Base
  belongs_to :user
  has_many :responsibility

  def company_text
    return "#{I18n.t 'company'} ##{id}" if company.nil? or company.empty?
    return company
  end

  def position_text
    return "#{I18n.t 'no_position'}" if position.nil? or position.empty?
    return position
  end
end
