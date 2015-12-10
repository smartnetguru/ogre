class Job < ActiveRecord::Base
  belongs_to :user
  has_many :responsibility

  def date_text
    dateformat =  "%b %d, %Y"
    retval = ""
    retval += start.strftime(dateformat) if start != nil
    retval += " - #{self.end.strftime(dateformat)}" if self.end != nil
  end
end
