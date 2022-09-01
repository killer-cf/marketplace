FactoryBot.define do
  factory :purchase do
    cpf { "MyString" }
    order { "MyString" }
    value { "9.99" }
    card_number { "MyString" }
    client { nil }
  end
end
