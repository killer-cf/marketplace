class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :product_items
  has_many :purchases

  def cart_total_value
    product_items.sum(&:subtotal)
  end
end
