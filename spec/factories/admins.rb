require 'faker'

FactoryBot.define do
  factory :admin do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { 'password' }
    status { :approved }
  end
end
