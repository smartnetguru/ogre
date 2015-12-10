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

# Beginning of nonsense for the sake of testing
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

# Project associated with a resume
project2 = Project.create({
  user: user,
  title: 'Venus Project',
  desc: 'Acted as friction to prevent naive utopian agenda from gaining traction',
  start: "1994"
})

# Resume skills
[
  'JavaScript',
  'Ruby on Rails',
  'Software Development'
].each_with_index do |skill, i|
  Skill.create({
    resume: resume,
    name: skill
  })
end

# Beginning of serious fake/real resume for testing export functionalities
resume = Resume.create({
  user_id: user.id,
  name: 'Slack Resume - Frontend Engineer',
  desc: 'First draft',
  website: 'www.dereksaif.com',
  email: 'saif.tareq@gmail.com',
  contactname: 'Tareq (Derek) Saif',
  phone: '510-555-5555',
  address: '123 Fake St. Richmond, CA'
})

job2 = Job.create({
  user_id: user.id,
  company: 'University of California Berkeley',
  position: 'Information Systems Analyst',
  location: 'Berkeley, CA',
  start: '01-05-2014',
  end: '01-06-2015'
})

job3 = Job.create({
  user_id: user.id,
  company: 'Lawrence Berkeley National Laboratory',
  position: 'Computer Systems Engineer Trainee',
  location: 'Berkeley, CA',
  start: '01-09-2011',
  end: '01-12-2012'
})

job1 = Job.create({
  user_id: user.id,
  company: 'Tekk Support',
  position: 'Business Owner / Principal Technician',
  location: 'San Pablo, CA',
  start: '01-03-2013',
  end: '01-05-2014'
})

# Job3 responsibilities
[
  'Managed web precence (Yelp, Facebook, Twitter)',
  'Created business page www.tekk-support.com on personal server including a contact page \
  backed by google\'s SMTP library and dynamic based on device',
  'Brought in clients through grassroots advertising partnerships with local businesses \
  and a successful flyering campaign'
].each_with_index do |res, i|
  resp = Responsibility.create({
    job_id: job1.id,
    text: res
  })
  resume.responsibilitys.push resp
end

# Job 2 responsibilities
[
  'Rethemed Sir Trevor JS (a library for content management that has no built \
  in theming functionality',
  'Extended Sir Trevor JS with custom blocks including arbitrary file upload',
  'Organized SASS files for one rails app deployed to two places with different themes \
  with asset precompilation based on environment variables',
  'Used AWS JavaScript SDK for client side uploading (progress bar + bypassing our server for performance)',
  'Used Shapeshift and Draggable jQuery libraries to create trough-like user interface',
  'Created jQuery plugin for autosave dialog functionality (comparable to Gmail\'s saving/saved dialog)',
  'Created jQuery plugin for creating an interactive vertical calendar (similar to Chronoline.js)',
  'Deployed Win64 binary to Heroku to run ACER ConQuest analysis software',
  'Responsibile for frontend work (all CSS and supplementary JS)'
].each_with_index do |res, i|
  resp = Responsibility.create({
    job_id: job2.id,
    text: res
  })
  resume.responsibilitys.push resp
end

# Job 3 responsibilities
[
  'Designed and implemented tools for provisioning and managing virtual machines and routers \
  to simulate specific network conditions',
  'Created a web frontend for these tools including user authentication that allowed users to \
  reserve computing time with a specifically configured network',
  'Implemented system monitoring to ensure availability of server (physical state through IPMI, \
  ping availability, and shell access)',
  'Automated creation of virtual machines including user and software configuration with a \
  single BASH command (for use by admins)'
].each_with_index do |res, i|
  resp = Responsibility.create({
    job_id: job3.id,
    text: res
  })
  resume.responsibilitys.push resp
end
