class Resume < ActiveRecord::Base
  belongs_to :user
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
    responsibility.each do |resp|
      retval[resp.job] = [] if (retval[resp.job] == nil)
      retval[resp.job].push(resp)
    end
  end
end
