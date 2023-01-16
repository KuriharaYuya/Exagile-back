require 'date'
require 'faker'

user = User.all[0]
50.times do
  character = Character.new(name: Faker::Name.name, user_id: user.uid)
  character.save
end

7.times do |i|
  3.times do |j| 
    start_time = Date.today - 3 + i + j
    end_time = start_time + 1.hour
    appoint = Appoint.create(user_id: user.uid, title: 'Test Appointment', desc: 'This is a test appointment', start: start_time, end: end_time, content: "test")

    characters = Character.where(user_id: user.uid).sample(3)
    characters.each do |character|
      3.times do |k|
        topic = Topic.create(character_id: character.id, appoint_id: appoint.id, title: "#{k}番目のtopic")
      end
    end
  end
end
