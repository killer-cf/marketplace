FactoryBot.define do
  factory :product_item do
    quantity { 1 }
    product { nil }
    client { nil }
  end
end
