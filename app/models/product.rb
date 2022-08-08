class Product < ApplicationRecord
  validates :name, :brand, :price, :description, :width, :height, :depth, :weight, :sku, presence: true
  validates :width, :height, :depth, :weight, :price, numericality: { greater_than: 0.0 }
  validates :sku, uniqueness: true
end
