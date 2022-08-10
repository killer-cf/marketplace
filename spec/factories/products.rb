require 'faker'

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.unique.product_name }
    brand { Faker::Commerce.brand }
    description { Faker::Lorem.sentence(word_count: 15) }
    price { Faker::Commerce.price(range: 0..1000.0, as_string: true) }
    sku { Faker::Alphanumeric.unique.alpha(number: 10) }
    width { Faker::Number.decimal(l_digits: 2) }
    height { Faker::Number.decimal(l_digits: 2) }
    depth { Faker::Number.decimal(l_digits: 2) }
    weight { Faker::Number.decimal(l_digits: 2) }
    status { 1 }
    after(:build) do |product|
      product.photos.attach(io: File.open(Rails.root.join('spec/support/files/iphone-13-1.jpg')),
                            filename: 'iphone-13-1.jpeg', content_type: 'image/jpeg')
    end
  end
end
