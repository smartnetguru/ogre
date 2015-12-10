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
  website: 'www.foo.bar',
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
  resp = Responsibility.create({
    job_id: job1.id,
    text: res
  })
  resp.resumes.push(resume) if i % 2 == 0
end

# Job2 responsibilities with some applicable to the resume
[
  'Develop mom virus',
  'EyePhone developer',
  'Bending Unit lead developer'
].each_with_index do |res, i|
  resp = Responsibility.create({
    job_id: job2.id,
    text: res
  })
  resp.resumes.push(resume) if i % 2 == 0
end

# Project associated with a resume
project1 = Project.create({
  user: user,
  title: 'Manhattan Project',
  desc: 'Assisted in project dedicated to alternative solutions to national disagreements',
  start: "13/08/1942",
  end: "15/08/1947"
})

project1.resumes.push resume
