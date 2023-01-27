require 'date'
require 'faker'

# rails db:drop && rails db:create && rails db:migrate && rails db:seed

uid = ENV["TEST_USER_ID"]
name = ENV["TEST_USER_NAME"]
email = ENV["TEST_USER_EMAIL"]
user = User.new(uid:, name:, email:)
user.save

5.times do |i|
  community = user.communities.build(name: "Community#{i}")
  community.save
end

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
        Topic.create(character_id: character.id, appoint_id: appoint.id, title: "#{k}番目のtopic")
      end
    end
  end
end

Character.all.each do |character|
  # characterには1~3個のコミュニティを紐づける
  communities = user.communities.sample(rand(1..3))
  communities.each do |community|
    relation = CharactersCommunity.create(character_id: character.id, community_id: community.id)
    relation.save
  end
end

Appoint.all.each do |appoint|
  # inspired_faqを作成
  user = User.all[0]
  rand(2..3).times do |i|
    faq = Faq.new(user_id: user.uid, inspired_appoint_id: appoint.id, name: "#{appoint.title}の#{i}番目のfaq")
    faq.save!
  end
end

user.appoints.all.each do |appoint|
  appliable_faqs = user.faqs - appoint.inspired_faqs
  randomly_selected_faqs = appliable_faqs.sample(3)
  randomly_selected_faqs.each do |faq|
    faq.update(applied_appoint_id: appoint.id)
    faq.save
  end
end
