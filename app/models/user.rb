class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :resume
  has_many :job
  has_many :project
  has_many :education
end
