FactoryBot.define do
  factory :card do
    name { "MyString" }
    cpf { "MyString" }
    number { "MyString" }
    code { 1 }
    valid { "2022-09-01" }
    client { nil }
  end
end
