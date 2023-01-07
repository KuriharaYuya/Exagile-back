require 'date'

user = User.all[0]

7.times do |i|
  3.times do |j|
    start_time = Date.today - 3 + i + j
    end_time = start_time + 1.hour
    Appoint.create(user_id: user.uid, title: 'Test Appointment', desc: 'This is a test appointment', start: start_time, end: end_time)
  end
end
