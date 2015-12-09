class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :responsibility
  def name_text
    return I18n.t('blank') if name.nil? or name.empty?
    return name
  end
  def desc_text
    return I18n.t('blank') if desc.nil? or desc.empty?
    return desc
  end
end
