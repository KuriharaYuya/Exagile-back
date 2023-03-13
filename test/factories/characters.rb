FactoryBot.define do
  factory :character do
    name { "Test Character" }
    profile { "This is a test character." }
    user_id { User.all.first.uid }
  end
end
