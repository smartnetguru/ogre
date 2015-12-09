# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
user.email = 'foo@bar.com'
user.password = 'asdfasdf'
user.password_confirmation = 'asdfasdf'
user.skip_confirmation!
user.save!

job1 = Job.create({
  user_id: user.id,
  company: 'ACME',
  position: 'QA',
  location: 'Grand Canyon'
})

job2 = Job.create({
  user_id: user.id,
  company: 'MomCorp',
  position: 'Engineer',
  location: 'New Newyork'
})

resume = Resume.create({
  user_id: user.id,
  name: 'alpha',
  desc: 'applying to an alpha job',
  website: '',
  email: 'alpha@beta.com',
  contactname: 'steve stevenson II',
  phone: '555-555-5555',
  address: '123 fake st springfield, or'
})

# Job1 responsibilities with some applicable to the resume
[
  'Help customers',
  'Sit in a cubicle',
  'Answer the phone'
].each_with_index do |res, i|
  resumeid = if (i+1) % 2 == 0 then resume.id else nil end
  Responsibility.create({
    job_id: job1.id,
    resume_id: resumeid,
    text: res
  })
end

# Job2 responsibilities with some applicable to the resume
[
  'Develop mom virus',
  'EyePhone developer',
  'Bending Unit lead developer'
].each_with_index do |res, i|
  resumeid = if (i+1) % 2 == 0 then resume.id else nil end
  Responsibility.create({
    job_id: job2.id,
    resume_id: resumeid,
    text: res
  })
end
