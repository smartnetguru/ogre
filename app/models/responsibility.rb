class Responsibility < ActiveRecord::Base
  belongs_to :job
  belongs_to :resume
end
