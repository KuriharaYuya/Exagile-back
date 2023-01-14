require 'date'
require 'faker'

user = User.all[0]

7.times do |i|
  3.times do |j|
    start_time = Date.today - 3 + i + j
    end_time = start_time + 1.hour
    Appoint.create(user_id: user.uid, title: 'Test Appointment', desc: 'This is a test appointment', start: start_time, end: end_time, content: "test")
  end
end

50.times do
  character = Character.new(name: Faker::Name.name, user_id: user.uid)
  character.save
end
Character.all.each do |character|
  3.times do |i|
    character.topics.build(title: "#{i}番目のtopic")
    character.save
  end
end
