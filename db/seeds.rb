require 'factory_bot_rails'

10.times do
  product = FactoryBot.create :product
  5.times { FactoryBot.create :stock_product, product: }
end
