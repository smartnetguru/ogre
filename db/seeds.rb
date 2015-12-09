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

job = Job.create({
  user_id: User.first.id,
  company: 'ACME',
  position: 'QA',
  location: 'Grand Canyon'
})

resume = Resume.create({
  user_id: User.first.id,
  name: 'alpha',
  desc: 'applying to an alpha job',
  website: '',
  email: 'alpha@beta.com',
  contactname: 'steve stevenson II',
  phone: '555-555-5555',
  address: '123 fake st springfield, or'
})

[
  'Help customers',
  'Sit in a cubicle',
  'Answer the phone'
].each do |res|
  Responsibility.create({
    job_id: job.id,
    resume_id: resume.id,
    text: res
  })
end
