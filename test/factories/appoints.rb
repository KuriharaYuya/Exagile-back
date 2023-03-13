FactoryBot.define do
  factory :appoint do
    user_id { create(:user).id }
    title { "Sample Appointment" }
    desc { "This is a sample appointment" }
    start { DateTime.now }
    content { "Sample Content" }
  end
end
