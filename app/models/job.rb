class Job < ActiveRecord::Base
  belongs_to :user
  has_many :responsibility

  def company_text
    return "#{I18n.t 'company'} ##{id}" if company.nil? or company.empty?
    return company
  end
end
