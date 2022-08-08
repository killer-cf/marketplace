class Product < ApplicationRecord
  validates :name, :brand, :price, :description, :width, :height, :depth, :weight, presence: true
end
