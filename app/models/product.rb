class Product < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  has_many_attached :photos

  validates :name, :brand, :price, :description, :width, :height, :depth, :weight, :sku, presence: true
  validates :width, :height, :depth, :weight, :price, numericality: { greater_than: 0.0 }
  validates :sku, uniqueness: true
  validates :sku, length: { is: 10 }
end
