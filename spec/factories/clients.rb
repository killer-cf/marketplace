FactoryBot.define do
  factory :client do
    email { Faker::Internet.email }
    password { 'password' }
  end
end
